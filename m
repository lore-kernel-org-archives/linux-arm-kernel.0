From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 15 Jan 2013 09:16:39 +0100
Subject: OMAP baseline test results for v3.8-rc3
In-Reply-To: <alpine.DEB.2.00.1301141756460.20390@utopia.booyaka.com>
References: <alpine.DEB.2.00.1301141756460.20390@utopia.booyaka.com>
Message-ID: <50F51067.5090008@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 01/14/2013 06:59 PM, Paul Walmsley wrote:
> Failing tests: needing investigation
> ------------------------------------
> 
> Build tests:
> 
> * rmk_3430_ldp_allnoconfig, rmk_4430_sdp_allnoconfig: twl4030 build failures
>   - in drivers/mfd/twl-core.c

The following patch fixes these:
https://lkml.org/lkml/2012/12/24/3


-- 
P?ter
