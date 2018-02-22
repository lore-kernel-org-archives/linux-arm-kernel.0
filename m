From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 22 Feb 2018 17:36:28 +0100
Subject: [PATCH RESEND] arm64: dts: cavium: fix PCI bus dtc warnings
In-Reply-To: <20180201213240.28862-1-robh@kernel.org>
References: <20180201213240.28862-1-robh@kernel.org>
Message-ID: <CAK8P3a1MXr7PeyTJKYj0vMuHYeTptYpOkowdqAcY-vZJ6aEEPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 1, 2018 at 10:32 PM, Rob Herring <robh@kernel.org> wrote:
> dtc recently added PCI bus checks. Fix these warnings:
>
> arch/arm64/boot/dts/cavium/thunder2-99xx.dtb: Warning (pci_bridge): Node /pci missing bus-range for PCI bridge
> arch/arm64/boot/dts/cavium/thunder2-99xx.dtb: Warning (unit_address_vs_reg): Node /pci has a reg or ranges property, but no unit name
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Jayachandran C <jnair@caviumnetworks.com>
> ---
> Arnd, Olof,
>
> Going thru my backlog of patches and found this one never made it
> upstream. Please apply.

Applied now, sorry for missing this.

      Arnd
