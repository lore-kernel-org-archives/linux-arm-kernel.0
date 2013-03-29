From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Fri, 29 Mar 2013 14:52:02 +0000
Subject: [PATCH-V2 0/6] ARM: dts: AM33XX: Cleanup and pinctrl binding
 support
In-Reply-To: <515436FF.9030703@ti.com>
References: <1364452963-22083-1-git-send-email-hvaibhav@ti.com>
 <515436FF.9030703@ti.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EC3DDC8@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Cousson, Benoit
> Sent: Thursday, March 28, 2013 5:57 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> devicetree-discuss at lists.ozlabs.org; Porter, Matt; jacmet at sunsite.dk
> Subject: Re: [PATCH-V2 0/6] ARM: dts: AM33XX: Cleanup and pinctrl
> binding support
> 
> Hi Vaibhav,
> 
> The series looks good to me, but unfortunately does not apply cleanly
> on
> top of the latest for_3.10/dts branch.
> 
> Could you rebase it?
> 
Benoit,

You can simply skip below two patches,

[PATCH 1/6] ARM: dts: AM33XX: Fix the i2c numbering to match hardware/TRM
[PATCH 3/6] ARM: dts: AM33XX: Fix gpio numbering to match hardware/TRM


You have already merged Anil Kumar's patch into your branch.

commit 9115b7c03565b5797714b2e819f6a79f040d8782
Author: AnilKumar Ch <anilkumar@ti.com>
Date:   Wed Nov 21 17:22:17 2012 +0530

    ARM: dts: AM33XX: Rename I2C and GPIO nodes



NOTE: I have build and boot tested by skipping above 2 patches.

Thanks,
Vaibhav
