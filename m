From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Wed, 25 Apr 2012 12:26:44 +0000
Subject: [PATCH-V3 3/3] ARM: OMAP3+: clock33xx: Add AM33XX clock tree data
In-Reply-To: <4F97E243.6000500@ti.com>
References: <1333458578-23073-1-git-send-email-hvaibhav@ti.com>
 <1333458578-23073-4-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1204241857260.24864@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83E9FD175@DBDE01.ent.ti.com>
 <4F97B891.1020601@ti.com>
 <79CD15C6BA57404B839C016229A409A83E9FD707@DBDE01.ent.ti.com>
 <4F97E243.6000500@ti.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83E9FDA47@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2012 at 17:08:43, Cousson, Benoit wrote:
> On 4/25/2012 12:20 PM, Hiremath, Vaibhav wrote:
> > On Wed, Apr 25, 2012 at 14:10:49, Cousson, Benoit wrote:
> 
> ...
> 
<snip>
> 
> > How would I know the rate of this clock in driver? Say for example, I want
> > to configure my internal divider based on input rate?
> > OR
> > I want to change the rate of dss_clk itself?
> > OR
> > Looking at debugfs, would I get the rate of dss_clk?
> 
> No because that clock will not exist anymore, but you will have the real 
> clock rate from the "dss_dss_clk".
> 

Thanks Benoit, I think I understand your perspective on Module Vs leaf node 
and now able to digest as well.
Probably Last Q, which I think clarify all my doubts,

Assume we have complete hwmod instance and built a device using 
omap_device_build() api, and also the driver is completely using runtime pm 
api's,
How can driver get the clk handle (required to get the rate)? 
Is there any api already available for this?

Thanks,
Vaibhav
