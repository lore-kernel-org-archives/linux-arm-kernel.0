From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 17 May 2013 17:54:50 -0600
Subject: [PATCH 1/2] ARM: config: tegra: enable T114 SPI
In-Reply-To: <1365594483-20651-1-git-send-email-ldewangan@nvidia.com>
References: <1365594483-20651-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <5196C34A.9000303@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/2013 05:48 AM, Laxman Dewangan wrote:
> Nvidia Tegra114 has the new spi controller whose driver
> is not compatible with older SoCs. The new driver is added
> for Tegra114 spi controller.

I have applied this to (squashed it into) Tegra's for-3.11/defconfig branch.
