From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 13 Nov 2012 12:13:18 -0700
Subject: [PATCH 1/3] ARM: tegra: dts: add sflash controller dt entry
In-Reply-To: <1352783021-25393-2-git-send-email-ldewangan@nvidia.com>
References: <1352783021-25393-1-git-send-email-ldewangan@nvidia.com>
 <1352783021-25393-2-git-send-email-ldewangan@nvidia.com>
Message-ID: <50A29BCE.5050005@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12/2012 10:03 PM, Laxman Dewangan wrote:
> Nvidia's Tegra20 have the SPI (SFLASH) controller to
> interface with spi flash device which is used for system
> boot. Add DT entry for this controller.

Thanks, applied to Tegra's for-3.8/dt branch.
