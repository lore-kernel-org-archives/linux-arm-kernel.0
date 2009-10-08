From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 08 Oct 2009 13:40:59 -0400 (EDT)
Subject: kirkwood: missing pci support for openrd_base board
In-Reply-To: <20091008133329.675796da@marrow.netinsight.se>
References: <200910081333.43065.dk-arm-linux@gmx.de>
	<20091008133329.675796da@marrow.netinsight.se>
Message-ID: <alpine.LFD.2.00.0910081337260.18779@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 8 Oct 2009, Simon Kagstrom wrote:

> On Thu, 8 Oct 2009 13:33:42 +0200
> Dieter Kiermaier <dk-arm-linux@gmx.de> wrote:
> 
> > Is PCI expected to work or are there some patches missing (and if so, where are they available?)
> 
> It's just because PCIe initialization isn't called. I sent this patch
> over a month ago, but it hasn't been merged yet:
> 
>   http://www.spinics.net/lists/arm-kernel/msg73112.html

Could you verify this still applies and works fine on the latest kernel 
and resend please?  Also don't forget to CC me or chances for me to miss 
the patch are greater.


Nicolas
