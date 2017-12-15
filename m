From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 15 Dec 2017 00:27:06 -0200
Subject: [PATCH 1/2] ARM: dts: imx6sx-sdb: Disable PCI support
In-Reply-To: <1513271667-1960-1-git-send-email-festevam@gmail.com>
References: <1513271667-1960-1-git-send-email-festevam@gmail.com>
Message-ID: <CAOMZO5Bco_-eci4CLUQqRhFOyK2f39xjihBien+c3kxSU_D06Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Thu, Dec 14, 2017 at 3:14 PM, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
>
> When I added PCI support for this board I was testing with mainline U-Boot,
> which has PCI support and enables the i.mx6sx PCI power domain.
>
> When running on a U-Boot without PCI support, such as the one provided
> by NXP a kernel hang is observed.
>
> Better to disable the pci node for now, until the i.MX6SX PCI power domain
> is properly implemented in the kernel.

Just sent two patches that add i.MX6SX PCI power domain support.

If they are accepted then this one can be discarded.

Patch 2/2 of this series should still be applied though.

Thanks
