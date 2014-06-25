From: marex@denx.de (Marek Vasut)
Date: Wed, 25 Jun 2014 23:28:11 +0200
Subject: [RFC] PCI: pci-imx6: Add delay to workaround kernel hang
In-Reply-To: <1403637507-9424-1-git-send-email-festevam@gmail.com>
References: <1403637507-9424-1-git-send-email-festevam@gmail.com>
Message-ID: <201406252328.11777.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, June 24, 2014 at 09:18:27 PM, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> When the mx6 PCI conctroller is initialized in the bootloader we see a
> kernel hang inside imx6_add_pcie_port().
> 
> Adding a 30ms delay allows the kernel to boot.
> 
> Suggested-by: David M?ller <d.mueller@elsoft.ch>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> I am happy to get feedback on how to properly fix this.

Honestly, I have no clue. I would expect Freescale to help us in solving this as 
they are the chip vendor, but they cannot help either :-(

Apologies, I really have no idea .

Best regards,
Marek Vasut
