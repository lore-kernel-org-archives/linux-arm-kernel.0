From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 24 Nov 2009 14:12:03 -0500 (EST)
Subject: [PATCH v2 06/17] ARM: dma-mapping: fix for speculative accesses
In-Reply-To: <20091124162250.GA17481@n2100.arm.linux.org.uk>
References: <E1NBYEF-0005l7-Tq@rmk-PC.arm.linux.org.uk>
	<E1NCZ7p-0002A0-Ib@rmk-PC.arm.linux.org.uk>
	<c70ff3ad0911230725h6d688c09k8576b66d012f29f0@mail.gmail.com>
	<20091123172722.GE18142@n2100.arm.linux.org.uk>
	<c70ff3ad0911240746v3438bba9y556cca3f027b3dd7@mail.gmail.com>
	<20091124162250.GA17481@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.0911241346140.2059@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 24 Nov 2009, Russell King - ARM Linux wrote:

> > I want to help with that testing, is there any git tree where I can
> > pull the code from?
> 
> There isn't, because apparantly under git rules, as soon as I publish it
> in git form it must be fixed.  So I'm keeping the stuff private and only
> issuing patches on this mailing list.

I think you should be perfectly fine publishing some Git branches with 
the explicit indication that such branches are unstable and volatile.  
After all that's exactly what the high profile linux-next repository is 
about, and everyone should know already that basing any work on top of 
linux-next is a good way to screw oneself.  And even then there is 'git 
rebase' to let you move your stuff onto a stable base if needed.

A very few individuals apparently have difficulties with the distinction 
between a stable and an unstable Git branch which should be their own 
problem.  That shouldn't prevent the rest of the world from using Git in 
such a way.  Even Linus is not against a daily rebasing linux-next.

You still can expand your Git branch namespace for clarity.  Branches 
such as those are quite unambiguous:

	unstable/wip/dma_mapping_v1
	unstable/wip/dma_mapping_v2

Etc.


Nicolas
