From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 11 Mar 2013 11:43:29 -0600
Subject: [PATCH V2 4/5] ARM: DT: tegra114: add KBC controller DT entry
In-Reply-To: <1362852678-13421-5-git-send-email-ldewangan@nvidia.com>
References: <1362852678-13421-1-git-send-email-ldewangan@nvidia.com>
 <1362852678-13421-5-git-send-email-ldewangan@nvidia.com>
Message-ID: <513E17C1.1070305@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/09/2013 11:11 AM, Laxman Dewangan wrote:
> NVIDIA's Tegra114 SoCs have the matrix keyboard controller which
> supports 11x8 type of matrix. The number of rows and columns
> are configurable.
> 
> Add DT entry for KBC controller with compatibility as "nvidia,tegra114-kbc",
> "nvidia,tegra20-kbc".

I thought the HW really wasn't compatible with Tegra20 due to the
reduced number of rows/columns/pins supported?
