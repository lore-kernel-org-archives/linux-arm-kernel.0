From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 15 Jul 2014 20:21:21 +0000 (UTC)
Subject: [Re-send PATCH 1/1] arm: dra7xx: Add hwmod data for MDIO and CPSW
In-Reply-To: <20140709100147.GB25154@breakpoint.cc>
References: <1404825399-10330-1-git-send-email-mugunthanvnm@ti.com>
 <20140709095552.GA25154@breakpoint.cc> <20140709100147.GB25154@breakpoint.cc>
Message-ID: <alpine.DEB.2.02.1407152019020.21432@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

On Wed, 9 Jul 2014, Sebastian Andrzej Siewior wrote:

> On 2014-07-09 11:55:52 [+0200], Sebastian Andrzej Siewior wrote:
> > On 2014-07-08 18:46:39 [+0530], Mugunthan V N wrote:
> > > Adding hwmod data for CPSW and MDIO which is present in DRA7xx SoC
> > 
> > I reverted my patch, applied this one and after boot I got:
> Oh me dum dum. I had --dry-run?
> 
> Acked-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
> 
> This is basically what Tony hasked me to do: No IRQ numbers & iomem.

Sorry - I'm a bit confused - Sebastian, did you test this one?  If so, is 
it okay to add a Tested-by from you?

Mugunthan, could you please get a Reviewed-by: from one of the folks on 
the DRA7xx SoC integration reviewers list that I sent earlier?


- Paul
