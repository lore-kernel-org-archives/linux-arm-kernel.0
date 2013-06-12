From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 11 Jun 2013 17:39:51 -0700
Subject: [PATCH 0/2] PLL m,n,p init from SoC files
In-Reply-To: <1370440301-3562-1-git-send-email-pdeschrijver@nvidia.com>
References: <1370440301-3562-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <20130612003951.8816.41684@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Peter De Schrijver (2013-06-05 06:51:24)
> The m,n,p fields don't have the same bit offset and width across all PLLs.
> This patchset allows SoC specific files to indicate the offset and width.
> It also provides the data for Tegra114.
> 

Taken into clk-next.

Thanks,
Mike

> Peter De Schrijver (2):
>   clk: tegra: allow PLL m,n,p init from SoC files
>   clk: tegra: PLL m,n,p init for Tegra114
> 
>  drivers/clk/tegra/clk-pll.c      |   60 ++++++++++++++++-------------
>  drivers/clk/tegra/clk-tegra114.c |   77 ++++++++++++++++++++++++++++++++++++++
>  drivers/clk/tegra/clk.h          |   32 ++++++++++------
>  3 files changed, 130 insertions(+), 39 deletions(-)
> 
> -- 
> 1.7.7.rc0.72.g4b5ea.dirty
