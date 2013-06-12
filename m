From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 11 Jun 2013 18:01:24 -0700
Subject: [PATCH v2 0/4] Override bits for PLLM
In-Reply-To: <1370515677-6807-1-git-send-email-pdeschrijver@nvidia.com>
References: <1370515677-6807-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <20130612010124.8816.81006@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Peter De Schrijver (2013-06-06 03:47:27)
> PLLM has override bits on Tegra30 and Tegra114. This patchset implements
> support for them for both Tegra30 and Tegra114.
> 
> Changes since v1:
>  * Remove some stray lines from 'clk: tegra: override bits for Tegra114 PLLM'

Pulled into clk-next.

Regards,
Mike

> 
> Peter De Schrijver (4):
>   clk: tegra: Add fields for override bits
>   clk: tegra: override bits for Tegra114 PLLM
>   clk: tegra: override bits for Tegra30 PLLM
>   clk: tegra: Use override bits when needed
> 
>  drivers/clk/tegra/clk-pll.c      |   82 ++++++++++++++++++++++---------------
>  drivers/clk/tegra/clk-tegra114.c |    9 ++++
>  drivers/clk/tegra/clk-tegra30.c  |   18 ++++++++
>  drivers/clk/tegra/clk.h          |    8 ++++
>  4 files changed, 84 insertions(+), 33 deletions(-)
> 
> -- 
> 1.7.7.rc0.72.g4b5ea.dirty
