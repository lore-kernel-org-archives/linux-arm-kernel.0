From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 26 Jan 2013 13:12:08 +0800
Subject: [PATCH 5/6] ARM: regulator: add tps6507x device tree data
In-Reply-To: <A4887BF146CD57468F700B415D2F4701581621@DBDE01.ent.ti.com>
References: <1359024920-32190-1-git-send-email-manishv.b@ti.com>
 <1359024920-32190-6-git-send-email-manishv.b@ti.com>
 <20130124120050.GP4955@opensource.wolfsonmicro.com>
 <A4887BF146CD57468F700B415D2F4701581621@DBDE01.ent.ti.com>
Message-ID: <20130126051206.GE10580@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 25, 2013 at 06:29:49AM +0000, Vishwanathrao Badarkhe, Manish wrote:
> On Thu, Jan 24, 2013 at 17:30:51, Mark Brown wrote:

> I too doubt that whether it should be in architecture specific folder,

> My code is in reference to below patch:
> arm/dts: regulator: Add tps65910 device tree data(d5d08e2e1672da627d7c9d34a9dc1089c653e23a)

> Could you please suggest me if it can be moved somewhere else?

We should have somewhere to put this sort of generic stuff, yes.  Not
sure where, possibly under drivers/of or some non-drivers part of the
tree.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130126/b12fc689/attachment.sig>
