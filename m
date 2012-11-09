From: mturquette@ti.com (Mike Turquette)
Date: Fri, 9 Nov 2012 14:21:40 -0800
Subject: [PATCH 15/26] ARM: omap2: clock: Add 24xx data using common
 struct clk
In-Reply-To: <alpine.DEB.2.00.1211092112340.20703@utopia.booyaka.com>
References: <1352337181-29427-1-git-send-email-mturquette@ti.com>
 <1352337181-29427-16-git-send-email-mturquette@ti.com>
 <alpine.DEB.2.00.1211081532210.20703@utopia.booyaka.com>
 <alpine.DEB.2.00.1211092030360.20703@utopia.booyaka.com>
 <20121109210543.17381.15878@nucleus>
 <alpine.DEB.2.00.1211092112340.20703@utopia.booyaka.com>
Message-ID: <20121109222140.17381.48700@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Paul Walmsley (2012-11-09 13:22:00)
> On Fri, 9 Nov 2012, Mike Turquette wrote:
> 
> > Quoting Paul Walmsley (2012-11-09 12:32:59)
> Re the upstream CCF support for this, would suggest adding the CCF support 
> for the new function pointer in this merge window (3.8) since it should 
> be relatively straightforward.  Then during the 3.9 merge window, the 
> OMAP code can be switched over to use it.
> 

Will do.

Regards,
Mike

> 
> - Paul
