From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Sep 2010 09:57:38 +0100
Subject: [PATCH] arm: fix pci_set_consistent_dma_mask for dmabounce devices
In-Reply-To: <m3sk1yzkjw.fsf@intrepid.localdomain>
References: <20100819174426O.fujita.tomonori@lab.ntt.co.jp>
	<m3sk1yzkjw.fsf@intrepid.localdomain>
Message-ID: <20100901085738.GJ8142@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 28, 2010 at 07:58:11PM +0200, Krzysztof Halasa wrote:
> What's the outcome of the following?
> 
> Russell, are you going to apply it as is, or is a better (short-term)
> fix being made?

I want to see a better solution to this first - without which we'll
apply this hack and then quietly forget about the problem.
