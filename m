From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 23 Aug 2012 16:20:31 +0100
Subject: [PATCH 1/2] ARM: S3C64XX: Update configuration for WM5102 module
 on Cragganmore
In-Reply-To: <1d5901cd8114$023550f0$069ff2d0$%kim@samsung.com>
References: <1344535549-4371-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <0db901cd76b4$7daf1730$790d4590$%kim@samsung.com>
 <20120810100713.GH24328@opensource.wolfsonmicro.com>
 <0eff01cd777f$4c9d1f90$e5d75eb0$%kim@samsung.com>
 <20120813122359.GA13446@opensource.wolfsonmicro.com>
 <1d5901cd8114$023550f0$069ff2d0$%kim@samsung.com>
Message-ID: <20120823152031.GH7995@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 23, 2012 at 06:45:19PM +0900, Kukjin Kim wrote:

> Yeah, actually SoC defconfig in mainline doesn't cover _real_ requirements
> for (mass) product. But I think, it's time we need to sort out the
> defconfigs so that we could use them efficiently on product. BTW, if
> enabling board in defconfig, at least, unexpected build breakages could be
> detected by testing defconfig before merge for mainline...

Right, sure.  I guess the main thing I'm saying here is that I don't
mind what happens here, it's certainly no problem for me turn them on in
the build if that's what people wants.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120823/0be86153/attachment.sig>
