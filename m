From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 10 Apr 2013 16:29:32 -0600
Subject: [PATCH 1/2] ARM: config: tegra: enable T114 SPI
In-Reply-To: <1365594483-20651-1-git-send-email-ldewangan@nvidia.com>
References: <1365594483-20651-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <5165E7CC.1010101@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/2013 05:48 AM, Laxman Dewangan wrote:
> Nvidia Tegra114 has the new spi controller whose driver
> is not compatible with older SoCs. The new driver is added
> for Tegra114 spi controller.

These 2, and the other 2 KBC patches you posted, all look reasonable.
They'll have to wait until 3.11 though.
