From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 16 Jul 2014 18:57:04 +0000 (UTC)
Subject: [Re-send PATCH 1/1] arm: dra7xx: Add hwmod data for MDIO and CPSW
In-Reply-To: <20140716070643.GC3378@breakpoint.cc>
References: <1404825399-10330-1-git-send-email-mugunthanvnm@ti.com>
 <20140709095552.GA25154@breakpoint.cc> <20140709100147.GB25154@breakpoint.cc>
 <alpine.DEB.2.02.1407152019020.21432@utopia.booyaka.com>
 <20140716070643.GC3378@breakpoint.cc>
Message-ID: <alpine.DEB.2.02.1407161854360.23074@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 16 Jul 2014, Sebastian Andrzej Siewior wrote:

> On 2014-07-15 20:21:21 [+0000], Paul Walmsley wrote:
> 
> > > Acked-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
> > > 
> > > This is basically what Tony hasked me to do: No IRQ numbers & iomem.
> > 
> > Sorry - I'm a bit confused - Sebastian, did you test this one?  If so, is 
> > it okay to add a Tested-by from you?
> 
> Tested-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>

Thanks Sebastian.

Mugunthan, next step would be for you to get a Reviewed-by: by someone who 
has access to the (non-public) DRA7xx TRM, and can review for SoC 
integration.  Since Rajendra is no longer at TI, the right person is 
probably Tony.

Then this patch should be mergeable.


- Paul
