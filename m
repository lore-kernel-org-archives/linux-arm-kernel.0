From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 5 Nov 2012 09:13:18 +0100
Subject: [PATCH] ARM: OMAP2+: AM33XX: clock data: fix mcasp entries
In-Reply-To: <CAD=GYpYuyfGuEgAWJyE2nkKx4GEsm=eDYAhV966sWVLbEPaqYQ@mail.gmail.com>
References: <1349879449-22657-1-git-send-email-mporter@ti.com>
 <1BAFE6F6C881BF42822005164F1491C33EAB8596@DBDE01.ent.ti.com>
 <CAD=GYpZ9w=D55G9DOiMqZ4BCGGdGszsgG3fumHUGZ12xx+TKjw@mail.gmail.com>
 <1BAFE6F6C881BF42822005164F1491C33EAB973D@DBDE01.ent.ti.com>
 <CAD=GYpYuyfGuEgAWJyE2nkKx4GEsm=eDYAhV966sWVLbEPaqYQ@mail.gmail.com>
Message-ID: <20121105081317.GC28886@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 03, 2012 at 02:32:59PM -0500, Joel A Fernandes wrote:

> beaglebone_defconfig: Add dummy regulator to init tlv320aic3x
> https://github.com/joelagnel/linux-kernel/commit/db5672dfe548d82625cf40ed688d05ba7cee5c93

This should never be done in production, you should ensure that the
appropriate supplies are provided by the board file or device tree.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121105/864f0b21/attachment.sig>
