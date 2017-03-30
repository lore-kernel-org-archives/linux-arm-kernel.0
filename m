From: slash.tmp@free.fr (Mason)
Date: Thu, 30 Mar 2017 13:09:04 +0200
Subject: [RFC PATCH v0.2] PCI: Add support for tango PCIe host bridge
In-Reply-To: <91db1f47-3024-9712-309a-fb4b21e42028@free.fr>
References: <91db1f47-3024-9712-309a-fb4b21e42028@free.fr>
Message-ID: <dcbf9767-d0bc-03f2-3664-7fd74b96969c@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/03/2017 14:05, Mason wrote:

> +/*
> + * This should probably be module_platform_driver ?
> + */
> +builtin_platform_driver(tango_pcie_driver);

For the sake of completeness,

ERROR: "pci_ecam_map_bus" [drivers/pci/host/pcie-tango.ko] undefined!
ERROR: "pci_host_common_probe" [drivers/pci/host/pcie-tango.ko] undefined!

The two above functions are currently not exported to modules.

I don't know whether this is intentional.

Regards.
