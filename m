From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 27 Nov 2012 08:37:48 +0000
Subject: linux-next: manual merge of the arm-soc tree with the usb tree
In-Reply-To: <20121127155732.c3422fdbf62501ee134024d7@canb.auug.org.au>
References: <20121127155732.c3422fdbf62501ee134024d7@canb.auug.org.au>
Message-ID: <201211270837.48458.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 27 November 2012, Stephen Rothwell wrote:
> @@@ -167,7 -184,9 +170,9 @@@ ehci_orion_conf_mbus_windows(struct usb
>         }
>   }
>   
> + static u64 ehci_orion_dma_mask = DMA_BIT_MASK(32);
> + 
>  -static int __devinit ehci_orion_drv_probe(struct platform_device *pdev)
>  +static int ehci_orion_drv_probe(struct platform_device *pdev)
>   {
>         struct orion_ehci_data *pd = pdev->dev.platform_data;
>         const struct mbus_dram_target_info *dram;

Looks good, thanks!

	Arnd
