From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 22 Aug 2011 09:59:14 -0400 (EDT)
Subject: Submitting patchset: ARM: Remove define CONSISTENT_DMA_SIZE
In-Reply-To: <1314018371.3604.27.camel@computer2>
References: <1312813712-22808-1-git-send-email-tixy@yxit.co.uk>
	<1314018371.3604.27.camel@computer2>
Message-ID: <alpine.LFD.2.00.1108220952040.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Aug 2011, Tixy wrote:

> I was wondering how I should submit the patches for removing
> CONSISTENT_DMA_SIZE. Following on from the thread in linux-arm-kernel
> titled "Patch Merging Path - RMK or Arnd?" [1], I'm guessing...
> 
> - Patch one, "ARM: Add init_consistent_dma_size()" to go into RMK's tree
> - All the patches to go into the arm-soc tree
> 
> Or do we have a plan to bundle up the cleanup patches for the single
> zImage work?

Even if this is touching mostly platform code, the concept is enforced 
in core code.  I would therefore recommend that you send RMK a pull 
request.  Either he'll just pull it, or he'll ask you to bounce it to 
Arnd.


Nicolas
