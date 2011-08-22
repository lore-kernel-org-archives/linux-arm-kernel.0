From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 22 Aug 2011 13:30:50 +0400
Subject: [PATCH 2/2] ARM: orion5x: fix build error in dns323_pci_map_irq
In-Reply-To: <1313953272-24733-2-git-send-email-robherring2@gmail.com>
References: <1313953272-24733-2-git-send-email-robherring2@gmail.com>
Message-ID: <4E5221CA.8090402@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 21-08-2011 23:01, Rob Herring wrote:

> From: Rob Herring<rob.herring@calxeda.com>

> orion5x fails to build with the following error:
> arch/arm/mach-orion5x/dns323-setup.c: In function ?dns323_pci_map_irq?:
> arch/arm/mach-orion5x/dns323-setup.c:80:28: error: expected expression before ?const?
> arch/arm/mach-orion5x/dns323-setup.c:80:28: error: too few arguments to function ?orion5x_pci_map_irq?

> This appears to be a search and replace error introduced from this commit:

> commit d5341942d784134f2997b3ff82cd63cf71d1f932
> Author:

    No author? :-)

> Date:   Fri Jun 10 15:30:21 2011 +0100

>      PCI: Make the struct pci_dev * argument of pci_fixup_irqs const.

> Signed-off-by: Rob Herring<rob.herring@calxeda.com>
> Cc: Ralf Baechle<ralf@linux-mips.org>
> Cc: Nicolas Pitre<nico@fluxnic.net>
> Cc: Arnd Bergmann<arnd@arndb.de>

WBR, Sergei
