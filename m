From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 14 Nov 2012 15:21:19 +0900
Subject: [PATCH 1/4] mfd: tps65217: Set PMIC to shutdowm on PWR_EN toggle
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA6B043@DBDE01.ent.ti.com>
References: <1352108549-9341-1-git-send-email-anilkumar@ti.com>
 <1352108549-9341-2-git-send-email-anilkumar@ti.com>
 <5097F078.50701@ti.com>
 <20121114022341.GM4415@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA6B043@DBDE01.ent.ti.com>
Message-ID: <20121114062117.GC7407@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 14, 2012 at 06:11:45AM +0000, AnilKumar, Chimata wrote:

> From these two threads we can infer that this is handled in power_off
> sequence only. And this is feature of PMIC to go to shutdown mode nothing
> to be fixed in silicon. PWR_EN line can be connected to any of these like
> PRCM control or GPIO or some other instead of RTC(in this case).

OK, but why are you telling me this?  What are you looking for me to do
with this information?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121114/3d0017b1/attachment-0001.sig>
