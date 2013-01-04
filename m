From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 4 Jan 2013 19:20:32 +0800
Subject: [PATCH v3 0/9] Migrate Tegra to common clock framework
In-Reply-To: <1357292453-28418-1-git-send-email-pgaikwad@nvidia.com>
References: <1357292453-28418-1-git-send-email-pgaikwad@nvidia.com>
Message-ID: <1357298432.12574.2.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-01-04 at 17:40 +0800, Prashant Gaikwad wrote:
> This patchset does following:
> 1. Decompose single tegra clock structure into multiple clocks.
> 2. Try to use standard clock types supported by common clock framework.
> 3. Use dynamic initialization.
> 4. Move all clock code to drivers/clk/tegra from mach-tegra.
> 5. Add device tree support for Tegra20 and Tegra30 clocks.
> 6. Remove all legacy clock code from mach-tegra.
> 
> Tested on Tegra30 (Cardhu) and Tegra20 (Ventana).
> 
> Changes from v2:
> Removed APB MISC node.
> Fixed some issues reported by Joseph Lo.
> Added function to read chip id revision register.
> 
> Changes from v1:
> Rebased on linux-next for 20121224.
> 
> Prashant Gaikwad (8):
>   ARM: tegra: Add function to read chipid
>   clk: tegra: Add tegra specific clocks
>   arm: tegra: Move tegra_cpu_car.h to linux/clk/tegra.h
>   ARM: Tegra: Define Tegra30 CAR binding
>   clk: tegra: add clock support for tegra20
>   clk: tegra: add clock support for tegra30
>   arm: tegra: Migrate to new clock code
>   arm: tegra: Remove legacy clock code
> 
> Stephen Warren (1):
>   ARM: tegra: Define Tegra20 CAR binding
> 

Good job, Prashant. :-)

This series :
Tested-by: Joseph Lo <josephl@nvidia.com>
