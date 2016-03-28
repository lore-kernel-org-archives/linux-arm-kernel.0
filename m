From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 28 Mar 2016 23:18:02 +0200
Subject: [PATCH 1/2] dt-bindings: pci: add DT binding for Marvell Armada
 7K/8K PCIe controller
In-Reply-To: <1459071058-18328-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1459071058-18328-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1459071058-18328-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <5192758.5yjNn0Uus9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 27 March 2016 11:30:57 Thomas Petazzoni wrote:
> +               ranges = <0x81000000 0 0xf9000000 0  0xf9000000 0 0x10000       /* downstream I/O */
> +                         0x82000000 0 0xf6000000 0  0xf6000000 0 0xf00000>;    /* non-prefetchable memory */
> 

No 64-bit (prefetchable) MMIO area? Is this a hardware limitation,
or did you just forget to add it?

	Arnd
