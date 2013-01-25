From: manishv.b@ti.com (Vishwanathrao Badarkhe, Manish)
Date: Fri, 25 Jan 2013 06:29:49 +0000
Subject: [PATCH 5/6] ARM: regulator: add tps6507x device tree data
In-Reply-To: <20130124120050.GP4955@opensource.wolfsonmicro.com>
References: <1359024920-32190-1-git-send-email-manishv.b@ti.com>
 <1359024920-32190-6-git-send-email-manishv.b@ti.com>
 <20130124120050.GP4955@opensource.wolfsonmicro.com>
Message-ID: <A4887BF146CD57468F700B415D2F4701581621@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Thu, Jan 24, 2013 at 17:30:51, Mark Brown wrote:
> On Thu, Jan 24, 2013 at 04:25:19PM +0530, Vishwanathrao Badarkhe, Manish wrote:
> 
> > ---
> >  arch/arm/boot/dts/tps6507x.dtsi |   47 +++++++++++++++++++++++++++++++++++++++
> 
> Why are you putting this in arch/arm?
> 

I too doubt that whether it should be in architecture specific folder,
My code is in reference to below patch:
arm/dts: regulator: Add tps65910 device tree data(d5d08e2e1672da627d7c9d34a9dc1089c653e23a)

Could you please suggest me if it can be moved somewhere else?

Regards, 
Manish
