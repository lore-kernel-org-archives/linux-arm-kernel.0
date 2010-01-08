From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 8 Jan 2010 12:44:43 +0100
Subject: [PATCH 2/4] mfd: mc13783: When probing, unlock the mc13783
	before subsystems initialisation.
In-Reply-To: <1262949215.2050.19.camel@climbing-alby>
References: <1260808880.2022.98.camel@climbing-alby>
	<1260810776.2022.130.camel@climbing-alby>
	<1260811085.2022.135.camel@climbing-alby>
	<1261152746.3356.72.camel@climbing-alby>
	<20091219201816.GA28742@pengutronix.de>
	<1261316918.5224.15.camel@climbing-alby>
	<20091220184941.GA13294@pengutronix.de>
	<1261349401.5224.154.camel@climbing-alby>
	<1262949215.2050.19.camel@climbing-alby>
Message-ID: <20100108114442.GB23619@sortiz.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alberto,

On Fri, Jan 08, 2010 at 12:13:35PM +0100, Alberto Panizzo wrote:
> Samuel, although patch [1/4] is not a matter of .33 
> I think this one [2/4] can go to mainline in this subversion.
> 
> As submitted by Valentin Longchamp here:
> 
> http://thread.gmane.org/gmane.linux.ports.arm.kernel/71128/focus=71127
> 
> this patch, Acked by Uwe, fix a little regression in mc13783-core.
Right, I'll push that upstream soon.

Cheers,
Samuel.


> Best Regards,
> Alberto!
> 

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
