From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 2 Nov 2012 14:22:39 +0000
Subject: [PATCH v2] ARM: S3C64XX: Fix up IRQ mapping for balblair on
 Cragganmore
In-Reply-To: <1351861454-20032-1-git-send-email-dp@opensource.wolfsonmicro.com>
References: <1351861454-20032-1-git-send-email-dp@opensource.wolfsonmicro.com>
Message-ID: <20121102142238.GX4413@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 02, 2012 at 01:04:14PM +0000, Dimitris Papastamos wrote:
> We are using S3C_EINT(4) instead of S3C_EINT(5).

Reviwed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121102/5ecfdda4/attachment.sig>
