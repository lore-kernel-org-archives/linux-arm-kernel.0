From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 Dec 2015 09:52:33 +0100
Subject: [PATCH 01/10] drivers/pci: make host/pci-imx6.c driver explicitly
 non-modular
In-Reply-To: <1449970917-12633-2-git-send-email-paul.gortmaker@windriver.com>
References: <1449970917-12633-1-git-send-email-paul.gortmaker@windriver.com>
 <1449970917-12633-2-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <1618604.7V7xXEyj55@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 12 December 2015 20:41:48 Paul Gortmaker wrote:
> The Kconfig for this option is currently:
> 
> config PCI_IMX6
>         bool "Freescale i.MX6 PCIe controller"
> 
> ...meaning that it currently is not being built as a module by anyone.
> Lets remove the couple traces of modularity, so that when reading the
> driver there is no doubt it is builtin-only.

Can you fix Kconfig instead?

	Arnd
