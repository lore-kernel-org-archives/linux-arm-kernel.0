From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 12 Feb 2014 11:49:20 +0000
Subject: [PATCH] ARM: shmobile: set proper DMA masks for Ether devices
In-Reply-To: <201402120255.25037.sergei.shtylyov@cogentembedded.com>
References: <201402120255.25037.sergei.shtylyov@cogentembedded.com>
Message-ID: <52FB5FC0.3010808@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/02/14 23:55, Sergei Shtylyov wrote:
> Ether MAC is a DMA-capable device and so should have 'dev.dma_mask' and
> 'dev.coherent_dma_mask' fields set properly, to reflect 32-bit DMA addressing
> ability.  Currently, the code works without DMA masks but in the future, when
> support for NETIF_F_HIGHDMA & NETIF_F_SG would be added to the 'sh_eth' driver,
> the DMA masks should start to matter...
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Hi, do you have a git branch available with all the changes for getting
ethernet working on rcar please?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
