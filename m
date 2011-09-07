From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 7 Sep 2011 11:30:17 +0200
Subject: [PATCH V2] ARM: mxs: Add initial support for DENX MX28
In-Reply-To: <1315377931-15770-1-git-send-email-sbabic@denx.de>
References: <1314604250-29511-1-git-send-email-sbabic@denx.de>
	<1315377931-15770-1-git-send-email-sbabic@denx.de>
Message-ID: <20110907093017.GA1912@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 07, 2011 at 08:45:31AM +0200, Stefano Babic wrote:
> Added initial support for DENX M28 module and M28EVK
> board. Ethernet(FEC), SDHC, Display are supported.
> 
> Signed-off-by: Stefano Babic <sbabic@denx.de>

Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

May I ask what bootloader do you use? The FSL-uboot or will there be mxs
support in mainline u-boot?

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110907/d0b543b4/attachment.sig>
