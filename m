From: nico@fluxnic.net (Nicolas Pitre)
Date: Sun, 11 Apr 2010 10:42:06 -0400 (EDT)
Subject: [PATCH] ARM: fix highmem with VIPT cache and DMA
In-Reply-To: <alpine.LFD.2.00.1003261144020.694@xanadu.home>
References: <alpine.LFD.2.00.1003251638030.694@xanadu.home>
	<1269610458.807.49.camel@e102109-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1003261144020.694@xanadu.home>
Message-ID: <alpine.LFD.2.00.1004111033010.7232@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Do you have concerns about patch #6007/1 that I might have missed? 
Otherwise it would be nice to move it towards mainline for ARMv6 
targets to work properly with highmem at last.


Nicolas
