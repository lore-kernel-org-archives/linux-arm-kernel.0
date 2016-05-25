From: robert.richter@cavium.com (Robert Richter)
Date: Wed, 25 May 2016 15:22:29 +0200
Subject: [PATCH v5] irqchip, gicv3-its, numa: Enable workaround for
 Cavium thunderx erratum 23144
In-Reply-To: <20160422090052.GA4236@arm.com>
References: <1460748606-28390-1-git-send-email-rrichter@caviumnetworks.com>
 <20160421174042.GD24726@rric.localdomain> <5719DA41.60304@arm.com>
 <20160422090052.GA4236@arm.com>
Message-ID: <20160525132229.GG1535@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will, Marc,

On 22.04.16 10:00:52, Will Deacon wrote:
> On Fri, Apr 22, 2016 at 09:01:05AM +0100, Marc Zyngier wrote:
> > On 21/04/16 18:40, Robert Richter wrote:
> > > On 15.04.16 21:30:05, Robert Richter wrote:
> > >> From: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
> > >>
> > >> The erratum fixes the hang of ITS SYNC command by avoiding inter node
> > >> io and collections/cpu mapping on thunderx dual-socket platform.
> > >>
> > >> This fix is only applicable for Cavium's ThunderX dual-socket platform.
> > >>
> > >> This is based on NUMA v16 series.
> > >> Message-Id: <1460155828-8690-1-git-send-email-ddaney.cavm@gmail.com>
> > > 
> > > Will, Catalin,
> > > 
> > > after NUMA base patches went into linux-next (many thanks), please
> > > consider this pass 1.x errata workaround for inclusion too.
> > 
> > I'll queue it as a fix once the NUMA patches are merged into mainline.
> 
> Yeah, this can probably go in as -rc1 material if you're happy with it.

I am going to send a rebased version 6 as there is a minor conflict
with upstream. Please include that one as numa fix after rc1 is out.

Thanks,

-Robert
