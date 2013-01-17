From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 17 Jan 2013 18:43:00 +0000 (UTC)
Subject: OMAP baseline test results for v3.8-rc3
In-Reply-To: <50F51067.5090008@ti.com>
References: <alpine.DEB.2.00.1301141756460.20390@utopia.booyaka.com>
 <50F51067.5090008@ti.com>
Message-ID: <alpine.DEB.2.00.1301171841350.14118@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi P?ter,

On Tue, 15 Jan 2013, Peter Ujfalusi wrote:

> On 01/14/2013 06:59 PM, Paul Walmsley wrote:
> > Failing tests: needing investigation
> > ------------------------------------
> > 
> > Build tests:
> > 
> > * rmk_3430_ldp_allnoconfig, rmk_4430_sdp_allnoconfig: twl4030 build failures
> >   - in drivers/mfd/twl-core.c
> 
> The following patch fixes these:
> https://lkml.org/lkml/2012/12/24/3

Thanks, I've added that info in the v3.8-rc3 test summary, and moved the
paragraph to the 'resolved by posted patches' section.


- Paul
