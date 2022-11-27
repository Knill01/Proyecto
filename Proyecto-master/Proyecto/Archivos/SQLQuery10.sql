USE [labdb]
GO
/****** Object:  StoredProcedure [dbo].[spLogin]    Script Date: 27/11/2022 02:00:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER procedure [dbo].[spLogin]
    @Username     varchar(50)
   ,@Pass		  varchar(50)
   ,@Nivel        INT     OUTPUT
   ,@ValidLogin   INT     OUTPUT
AS 
BEGIN
  SET NOCOUNT ON;        

    IF EXISTS (SELECT * FROM usuarios
               WHERE nombre = @Username OR email=@Username
                 AND pass = @Pass)
      BEGIN               
            SELECT @ValidLogin = 1 
                  ,@Nivel = CASE WHEN nivel=1
                                 THEN 1 
								 WHEN nivel=2
								 THEN 2
								 when nivel=3
								 then 3
								 ELSE 0 END
            FROM usuarios
            WHERE nombre = @Username OR email=@Username
              AND pass = @Pass
      END
    ELSE
      BEGIN
            SET @ValidLogin = 0;
      END
END