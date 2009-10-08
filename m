From: dk-arm-linux@gmx.de (Dieter Kiermaier)
Date: Thu, 8 Oct 2009 13:44:09 +0200
Subject: kirkwood: missing pci support for openrd_base board
In-Reply-To: <20091008133329.675796da@marrow.netinsight.se>
References: <200910081333.43065.dk-arm-linux@gmx.de>
	<20091008133329.675796da@marrow.netinsight.se>
Message-ID: <200910081344.09483.dk-arm-linux@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simon,

> 
> (I suggest we move this discussion to the OpenRD mailing list only in
> the future)
> 
> On Thu, 8 Oct 2009 13:33:42 +0200
> Dieter Kiermaier <dk-arm-linux@gmx.de> wrote:
> 
> > I try most recent kernel form kernel.org:
> > 
> > Linux DB88FXX81 2.6.32-rc3-00052-g0eca52a #5 PREEMPT Thu Oct 8 13:20:27 CEST 2009 armv5tel GNU/Linux
> > 
> > So everything else seems to work well but I can't get pci bus working?
> > Is PCI expected to work or are there some patches missing (and if so, where are they available?)
> 
> It's just because PCIe initialization isn't called. I sent this patch
> over a month ago, but it hasn't been merged yet:
> 
>   http://www.spinics.net/lists/arm-kernel/msg73112.html

Many thanks for the patch - I've googled a lot but can't find the information.
Sorry for the noise!

Dieter


> 
> // Simon
> 
> --~--~---------~--~----~------------~-------~--~----~
> You received this message because you are subscribed to the Google Groups "OpenRD" group.
> To post to this group, send email to openrd at googlegroups.com
> To unsubscribe from this group, send email to openrd+unsubscribe at googlegroups.com
> For more options, visit this group at http://groups.google.com/group/openrd?hl=en
> -~----------~----~----~----~------~----~------~--~---
> 
