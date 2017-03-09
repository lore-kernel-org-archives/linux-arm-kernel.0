From: roszenrami@gmail.com (Rami Rosen)
Date: Thu, 9 Mar 2017 23:59:18 +0200
Subject: [PATCH v3 08/23] Documentation: PCI: Add binding documentation
 for pci-test endpoint function
In-Reply-To: <1489046254-19919-9-git-send-email-kishon@ti.com>
References: <1489046254-19919-1-git-send-email-kishon@ti.com>
 <1489046254-19919-9-git-send-email-kishon@ti.com>
Message-ID: <CAKoUArkTXbMvfTmNjA_VGWodbP5JxVNBP1DNUTYND2LvUfKsJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
Minor comment: typo, should be: don't care:

> +revid           : dont't care
> +progif_code     : don't care
> +subclass_code   : don't care
> +baseclass_code  : should be 0xff
> +cache_line_size         : don't care
> +subsys_vendor_id : don't care
> +subsys_id       : don't care
> +interrupt_pin   : Should be 1 - INTA, 2 - INTB, 3 - INTC, 4 -INTD
> +msi_interrupts  : Should be 1 to 32 depending on the number of msi

Regards,
Rami Rosen
