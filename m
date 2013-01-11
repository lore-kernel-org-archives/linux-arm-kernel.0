From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 11 Jan 2013 14:44:49 +0000
Subject: [PATCH 0/2] ARM: tegra: Add cpu node in device tree
In-Reply-To: <1357909914-28994-1-git-send-email-hdoyu@nvidia.com>
References: <1357909914-28994-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <20130111144449.GF30538@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 11, 2013 at 01:11:52PM +0000, Hiroshi Doyu wrote:
> Hi,
> 
> From the discussion(*1) of CPU core# detection, DT cpu node will be
> the only way to do it right. So we need to add cpu nodes on the
> existing Tegra SoCs(T20/T30) first in order to remove the existing A9
> SCU detection later, where DT cpu# detection fails, we would consider
> a single cpu core avalable.
> 
> Tested only with T30.
> 
> Hiroshi Doyu (2):
>   ARM: tegra20: Add cpu node
>   ARM: tegra30: Add cpu node
> 
>  arch/arm/boot/dts/tegra20.dtsi |   29 +++++++++++++++++++++++++++++
>  arch/arm/boot/dts/tegra30.dtsi |   29 +++++++++++++++++++++++++++++
>  2 files changed, 58 insertions(+)
> 
> *1:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/140209.html
Looks ok, but you should copy devicetree-discuss at lists.ozlabs.org for
any set DT related.

FWIW on the series:

Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
