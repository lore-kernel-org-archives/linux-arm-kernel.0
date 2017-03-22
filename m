From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 22 Mar 2017 10:14:14 -0700
Subject: [PATCH] arm64: dts: NS2: Add dma-coherent to relevant DT
In-Reply-To: <1490129479-19459-1-git-send-email-jon.mason@broadcom.com>
References: <1490129479-19459-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <20170322171414.26039-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 21 Mar 2017 16:51:19 -0400, Jon Mason <jon.mason@broadcom.com> wrote:
> Cache related issues with DMA rings and performance issues related to
> caching are being caused by not properly setting the "dma-coherent" flag
> in the device tree entries. Adding it here to correct the issue.
>
> Signed-off-by: Jon Mason <jon.mason@broadcom.com>
> Fixes: fd5e5dd56 ("arm64: dts: Add PCIe0 and PCIe4 DT nodes for NS2")
> Fixes: dddc3c9d7 ("arm64: dts: NS2: add AMAC ethernet support")
> Fixes: e79249143 ("arm64: dts: Add Broadcom Northstar2 device tree entries for PDC driver")
> Fixes: ac9aae00f ("arm64: dts: Add SATA3 AHCI and SATA3 PHY DT nodes for NS2")
> Fixes: efc877676 ("arm64: dts: Add SDHCI DT node for NS2")
> ---

Applied, thanks!
--
Florian
