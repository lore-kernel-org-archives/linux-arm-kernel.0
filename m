From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 5 Aug 2015 20:30:52 +0530
Subject: [PATCH 00/11] omap_hsmmc: voltage switching and tuning
In-Reply-To: <20150805104355.GE16878@atomide.com>
References: <1438242394-25599-1-git-send-email-kishon@ti.com>
 <20150805104355.GE16878@atomide.com>
Message-ID: <55C22524.5050304@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wednesday 05 August 2015 04:13 PM, Tony Lindgren wrote:
> * Kishon Vijay Abraham I <kishon@ti.com> [150730 00:49]:
>> Patch series implements voltage switching and tuning for omap_hsmmc
>> driver.
>>
>> Did basic read/write test in J6, J6 Eco, Beagle-x15, AM437x EVM,
>> Beaglebone black, OMAP5 uEVM and OMAP4 PANDA.
> 
> Your tests are missing omap3?

I don't have one at my disposal :-( I'll try to find one and add omap3 tests.
> 
> I suggest you add some omap3 tests in general as otherwise you are
> only testing a subset of the driver features and completely missing
> things like rutnime PM and save and restore for the deeper idle
> states.

yeah, I'll do those tests and re-post the series.

Thanks
Kishon
