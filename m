From: robh@kernel.org (Rob Herring)
Date: Mon, 3 Apr 2017 09:51:15 -0500
Subject: [PATCH v3 2/2] PCI: Add tango PCIe host bridge support
In-Reply-To: <65114e62-7458-b6f7-327c-f07a5096a452@sigmadesigns.com>
References: <5309e718-5813-5b79-db57-9d702b50d0f9@sigmadesigns.com>
 <65114e62-7458-b6f7-327c-f07a5096a452@sigmadesigns.com>
Message-ID: <20170403145115.kjy46bbjt67jxa3k@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 29, 2017 at 01:34:45PM +0200, Marc Gonzalez wrote:
> This driver is used to work around HW bugs in the controller.
> 
> Note: the controller does NOT support the following features.
> 
>   Legacy PCI interrupts
>   IO space
> 
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> ---
>  Documentation/devicetree/bindings/pci/tango-pcie.txt |  33 +++++++++

Acked-by: Rob Herring <robh@kernel.org> 

>  drivers/pci/host/Kconfig                             |   7 ++
>  drivers/pci/host/Makefile                            |   1 +
>  drivers/pci/host/pcie-tango.c                        | 150 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 191 insertions(+)
