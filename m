From: richardcochran@gmail.com (Richard Cochran)
Date: Sun, 1 May 2011 17:59:07 +0200
Subject: [PATCH] ARM: Include Makefile.boot only when it exists
In-Reply-To: <alpine.LFD.2.00.1105010848360.24613@xanadu.home>
References: <1303103976-4922-1-git-send-email-eric.y.miao@gmail.com>
	<20110420083258.GB1517@S2100-06.ap.freescale.net>
	<BANLkTiknesdF7cMZ=RGJAh75aW_wRpyj-w@mail.gmail.com>
	<20110428152735.GU17290@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1104281925500.24613@xanadu.home>
	<20110501060922.GB2967@riccoc20.at.omicron.at>
	<alpine.LFD.2.00.1105010848360.24613@xanadu.home>
Message-ID: <20110501155907.GA3312@riccoc20.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 01, 2011 at 09:07:53AM -0400, Nicolas Pitre wrote:
> On Sun, 1 May 2011, Richard Cochran wrote:
> 
> > On Thu, Apr 28, 2011 at 09:00:08PM -0400, Nicolas Pitre wrote:
> >  
> > > Remember that one of the selling point for DT is to be able to boot
> > > an existing kernel binary on yet-to-be-created hardware simply by
> > > creating the appropriate DT description for it.
> > 
> > So, can you report from your own experience that it really works like
> > that?
> 
> No.  I'm firmly in the DT-still-has-to-prove-itself camp and I wish I 
> I'd never had to deal with it.  I believe that the current way for 
> configuring hardware on ARM is more reliable and less prone to errors 
> and bugs such as what you described about Freescale powerpc boards.  

Yes, I would agree that the current way works well.

> And for the record I don't believe the current crisis about ARM board 
> code duplication can be directly linked to the lack of DT support on ARM 
> even if many people are blending those issues together.

Sometimes it seems that DT is being promoted as a silver bullet.
 
> > I surely cannot.
> 
> If so then this whole DT idea has been oversold with false pretenses.  
> In good faith I'm willing to try it out and so I'm working towards its 
> implementation for ARM not against it, but if the DTS files are to be 
> maintained out of tree then all I can see for the future is additional 
> maintenance pain not less.

I think the DT advocates really believe in it (not with false, but
honest pretenses). Also, I agree that DT sounds great in theory, but,
in my experience, it has been not so great in practice.

Richard
