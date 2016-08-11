From: duwe@lst.de (Torsten Duwe)
Date: Thu, 11 Aug 2016 18:46:03 +0200
Subject: [PATCH v2 2/2] arm64: implement live patching
In-Reply-To: <alpine.LNX.2.00.1607111556320.27989@pobox.suse.cz>
References: <20160627151500.2247A68D20@newverein.lst.de>
 <20160627151722.B81C968D29@newverein.lst.de>
 <alpine.LNX.2.00.1607111556320.27989@pobox.suse.cz>
Message-ID: <20160811164603.GA24751@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2016 at 04:03:08PM +0200, Miroslav Benes wrote:
> On Mon, 27 Jun 2016, Torsten Duwe wrote:
> > +
> > +#ifdef CONFIG_LIVEPATCH
> 
> A nit but we removed such guards in the other header files.

I just notice this has fallen between the cracks :-/

	Torsten
