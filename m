From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 13 Nov 2012 12:13:27 -0700
Subject: [PATCH 2/3] ARM: tegra: Add OF_DEV_AUXDATA for sflash driver
 in board dt
In-Reply-To: <1352783021-25393-3-git-send-email-ldewangan@nvidia.com>
References: <1352783021-25393-1-git-send-email-ldewangan@nvidia.com>
 <1352783021-25393-3-git-send-email-ldewangan@nvidia.com>
Message-ID: <50A29BD7.4020209@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12/2012 10:03 PM, Laxman Dewangan wrote:
> Add OF_DEV_AUXDATA for sflash controller driver for Tegra20
> board dt files.
> Set the parent clock of sflash controller to PLLP and configure
> clock to 20MHz.

Thanks, applied to Tegra's for-3.8/soc branch.
