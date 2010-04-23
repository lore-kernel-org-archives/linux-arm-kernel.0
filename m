From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 23 Apr 2010 14:22:01 -0400 (EDT)
Subject: [PATCH v2] MTD: Fix Orion NAND driver compilation with ARM OABI
In-Reply-To: <20100423110037.f8790476.akpm@linux-foundation.org>
References: <20100325152505.17612.40158.stgit@pauliusz>
	<alpine.LFD.2.00.1003251225500.694@xanadu.home>
	<4BB33988.9070608@gmail.com> <1272023778.6917.6.camel@localhost>
	<alpine.LFD.2.00.1004230853230.7232@xanadu.home>
	<1272035596.11751.1437.camel@localhost.localdomain>
	<alpine.LFD.2.00.1004231308300.7232@xanadu.home>
	<20100423110037.f8790476.akpm@linux-foundation.org>
Message-ID: <alpine.LFD.2.00.1004231421130.7232@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 23 Apr 2010, Andrew Morton wrote:

> On Fri, 23 Apr 2010 13:50:10 -0400 (EDT)
> Nicolas Pitre <nico@fluxnic.net> wrote:
> 
> > > Fine with me, but not up to me. But I guess Andrew could merge it.
> > 
> > The patch is providing a fix to my own code, and I acked it already. The 
> > root of the problem is a defficiency in gcc, and dwmw2 asked that a PR 
> > be filled for that and a reference to it added to the patch.  This has 
> > been done.
> 
> Well, I merged it and can send it upstream.  But Jamie's observations
> give me pause?

What observation?  Let me find that.


Nicolas
