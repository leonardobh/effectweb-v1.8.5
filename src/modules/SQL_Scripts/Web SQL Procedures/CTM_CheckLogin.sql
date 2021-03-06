USE [CTM_TeaM]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CTM_CheckLogin]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[CTM_CheckLogin]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

-----------------------------------------------------------
-- Effect Web MuOnline
-- CTM_CheckLogin
-- Release 30/06/2011
-- Powered by Erick-Master
-----------------------------------------------------------

CREATE PROCEDURE [dbo].[CTM_CheckLogin]
@Account VARCHAR(10),
@Password VARCHAR(10),
@md5 int
AS
BEGIN
DECLARE @Valid int;
SET @Valid = 0;

IF @md5 = 1
BEGIN
	DECLARE @Hash BINARY(16);
	EXEC master..XP_MD5_EncodeKeyVal @Password, @Account, @Hash OUT;
	SELECT @Valid = 1 FROM MuOnline.dbo.MEMB_INFO WHERE memb___id = @Account AND memb__pwd = @Hash;
END
IF @md5 = 0
BEGIN
	SELECT @Valid = 1 FROM MuOnline.dbo.MEMB_INFO WHERE memb___id = @Account AND memb__pwd = @Password;
END

SELECT @Valid;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

