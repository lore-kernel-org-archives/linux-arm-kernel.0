From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Apr 2010 20:41:21 +0100
Subject: [PATCH] ARM: fix highmem with VIPT cache and DMA
In-Reply-To: <alpine.LFD.2.00.1004111033010.7232@xanadu.home>
References: <alpine.LFD.2.00.1003251638030.694@xanadu.home>
	<1269610458.807.49.camel@e102109-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1003261144020.694@xanadu.home>
	<alpine.LFD.2.00.1004111033010.7232@xanadu.home>
Message-ID: <20100412194121.GQ3048@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 11, 2010 at 10:42:06AM -0400, Nicolas Pitre wrote:
> Do you have concerns about patch #6007/1 that I might have missed? 
> Otherwise it would be nice to move it towards mainline for ARMv6 
> targets to work properly with highmem at last.

I don't think so; remember I've been away for Easter so things have
been slow this last week and a bit.

Once Linus has pulled the current crop of stuff, I'll see about merging
it.
