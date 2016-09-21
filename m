From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 Sep 2016 22:47:47 +0200
Subject: [PATCH v4 0/2] ARM: cleanup PCI specific configs
In-Reply-To: <1473848346-17905-1-git-send-email-kishon@ti.com>
References: <1473848346-17905-1-git-send-email-kishon@ti.com>
Message-ID: <3547319.cIOFfkHalq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, September 14, 2016 3:49:04 PM CEST Kishon Vijay Abraham I wrote:
> This series was initially sent to add support for two PCIe
> ports in dra7. This included selecting PCI_DOMAINS config
> in SOC_DRA7XX.
> 
> However from the review, PCI_DOMAINS can instead be selected
> from ARCH_MULTIPLATFORM. This is fixed in this series along
> with removing PCI_DOMAINS from other configs.
> 
> Changes from v3:
> *) Added *Acked-by:*
> *) Fixed $subject to not have *Fix*
> 
> Kishon Vijay Abraham I (2):
>   ARM: stop *MIGHT_HAVE_PCI* config from being selected redundantly
>   ARM: select PCI_DOMAINS config from ARCH_MULTIPLATFORM
> 

Applied both to next/cleanup now.

	Arnd
