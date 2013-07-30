From: nm@ti.com (Nishanth Menon)
Date: Tue, 30 Jul 2013 15:28:17 -0500
Subject: OMAP baseline test results for v3.10-rc6
In-Reply-To: <alpine.DEB.2.02.1307302001500.4505@utopia.booyaka.com>
References: <alpine.DEB.2.02.1306170521020.9909@utopia.booyaka.com>
 <20130625160243.GE22312@arwen.pp.htv.fi>
 <alpine.DEB.2.02.1306251746060.14373@utopia.booyaka.com>
 <51C9F0A8.1050607@ti.com>
 <alpine.DEB.2.02.1306261713260.6135@utopia.booyaka.com>
 <51CB4C20.3060306@ti.com>
 <alpine.DEB.2.02.1307290826180.30864@utopia.booyaka.com>
 <51F66024.1030804@ti.com>
 <alpine.DEB.2.02.1307302001500.4505@utopia.booyaka.com>
Message-ID: <51F821E1.3040808@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/30/2013 03:23 PM, Paul Walmsley wrote:

> Do you know if anyone ever got serial cold-booting working well for, say,
> OMAP3 and OMAP4 chips?

I had done configuration header based OMAP3 boot[1] once upon a time, 
but serial boot straight to kernel, we need a second that gives control 
there.. could be done, have'nt heard it done + I dont directly see a 
customer usage model for it ("ROI for investment of time") - so doubt 
any investment was done.

CH was the closest I could get to avoiding bootloaders in it's entirety. 
but the level of interest fell off when there was no viable usage model 
for the same.


[1] http://marc.info/?t=127232401100003&r=1&w=2
-- 
Regards,
Nishanth Menon
