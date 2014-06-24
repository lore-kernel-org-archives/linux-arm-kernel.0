From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Jun 2014 20:22:24 +0200
Subject: [PATCH v4 0/3] Add R8A7791/Koelsch/Henninger board PCI DT support
In-Reply-To: <201406242207.32790.sergei.shtylyov@cogentembedded.com>
References: <201406242207.32790.sergei.shtylyov@cogentembedded.com>
Message-ID: <9076479.78BOG4SjZ9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 June 2014 22:07:31 Sergei Shtylyov wrote:
> 
>    Here's the set of 3 patches against Simon Horman's 'renesas.git' repo,
> 'renesas-devel-v3.16-rc2-20140623' tag. Here we add PCI USB device tree support
> for the R8A7791-based Koelsch and Henninger boards. As the 'pci-rcar-gen2'
> driver device tree support has been merged for 3.16, this patchset can now be
> merged too... 
> 
> [1/3] ARM: shmobile: r8a7791: add internal PCI bridge nodes
> [2/3] ARM: shmobile: koelsch: enable internal PCI
> [3/3] ARM: shmobile: henninger: enable internal PCI
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
