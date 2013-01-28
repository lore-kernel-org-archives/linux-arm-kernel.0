From: manishv.b@ti.com (Vishwanathrao Badarkhe, Manish)
Date: Mon, 28 Jan 2013 05:01:36 +0000
Subject: [PATCH 5/6] ARM: regulator: add tps6507x device tree data
In-Reply-To: <20130126051206.GE10580@opensource.wolfsonmicro.com>
References: <1359024920-32190-1-git-send-email-manishv.b@ti.com>
 <1359024920-32190-6-git-send-email-manishv.b@ti.com>
 <20130124120050.GP4955@opensource.wolfsonmicro.com>
 <A4887BF146CD57468F700B415D2F4701581621@DBDE01.ent.ti.com>
 <20130126051206.GE10580@opensource.wolfsonmicro.com>
Message-ID: <A4887BF146CD57468F700B415D2F470158173C@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 26, 2013 at 10:42:08, Mark Brown wrote:
> On Fri, Jan 25, 2013 at 06:29:49AM +0000, Vishwanathrao Badarkhe, Manish wrote:
> > On Thu, Jan 24, 2013 at 17:30:51, Mark Brown wrote:
> 
> > I too doubt that whether it should be in architecture specific folder,
> 
> > My code is in reference to below patch:
> > arm/dts: regulator: Add tps65910 device tree 
> > data(d5d08e2e1672da627d7c9d34a9dc1089c653e23a)
> 
> > Could you please suggest me if it can be moved somewhere else?
> 
> We should have somewhere to put this sort of generic stuff, yes.  Not sure where, possibly under drivers/of or some non-drivers part of the tree.
> 

Right now, nobody has put this kind of generic stuff other than architecture folder. 
Later on We can move these kind of generic stuff somewhere else in one shot.


Regards, 
Manish
