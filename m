From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 14 Nov 2012 16:00:48 +0900
Subject: [PATCH 1/4] mfd: tps65217: Set PMIC to shutdowm on PWR_EN toggle
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA6B0AF@DBDE01.ent.ti.com>
References: <1352108549-9341-1-git-send-email-anilkumar@ti.com>
 <1352108549-9341-2-git-send-email-anilkumar@ti.com>
 <5097F078.50701@ti.com>
 <20121114022341.GM4415@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA6B043@DBDE01.ent.ti.com>
 <20121114062117.GC7407@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA6B0AF@DBDE01.ent.ti.com>
Message-ID: <20121114070046.GE7407@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 14, 2012 at 06:49:58AM +0000, AnilKumar, Chimata wrote:

> Earlier you have a comment on this thread, I am adding my comments
> on top of it. Sorry if I am in wrong direction.

Ah, I see.  I was just commenting because Benoit was asking if this
should be supported with a standard framework feature - I'm not
convinced that it should right now as there's not any clear patterns in
hardware behaviour.  I've no specific interest in this system.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121114/82583125/attachment.sig>
