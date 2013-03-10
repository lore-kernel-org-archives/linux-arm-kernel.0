From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Sun, 10 Mar 2013 23:37:12 +0100
Subject: [PATCH V2 1/5] ARM: DT: tegra114: add APB DMA controller DT entry
In-Reply-To: <1362852678-13421-2-git-send-email-ldewangan@nvidia.com>
References: <1362852678-13421-1-git-send-email-ldewangan@nvidia.com>
 <1362852678-13421-2-git-send-email-ldewangan@nvidia.com>
Message-ID: <20130310223712.GE4743@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 09, 2013 at 11:41:14PM +0530, Laxman Dewangan wrote:
> NVIDIA's Tegra114 has 32 channels APB DMA controller. Add DT entry for
> APB DMA controllers and make it compatible with "nvidia,tegra114-apbdma".
> 
> Tegra114 DMA controller is not compatible with Tegra30/Tegra20 DMA
> controller driver as in T114, the global pause also clock gate the

"clockgates"? "clock-gates"?

> DMA register and hence it iw not possible to write the DMA register

"it is not"

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130310/d41eb1fe/attachment.sig>
