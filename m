From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 12 Aug 2013 11:09:52 -0600
Subject: [PATCHv9 00/10] MSI support for Marvell EBU PCIe driver
In-Reply-To: <20130812163723.GK25111@titan.lakedaemon.net>
References: <1376080035-29344-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130812163723.GK25111@titan.lakedaemon.net>
Message-ID: <520916E0.5030404@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/2013 10:37 AM, Jason Cooper wrote:
> Thomas,
> 
> Whole series applied as follows:
> 
> +---+ mvebu/msi_pci (1-4,7)
>     |
>     +---+---+ mvebu/msi_irq (5,6)
>             |
>             +---+---+ mvebu/msi_mvebu (8-10)
> 
> mvebu/msi_pci built successfully with Randy's config for x86_64.
> 
> Thierry, I've tagged mvebu/msi_pci.  Unless it all falls apart in -next,
> those commit-id's won't change from what will be in arm-soc.

So, the branch still isn't stable, hence I shouldn't use it as a
baseline to apply Thierry's PCIe patches?
