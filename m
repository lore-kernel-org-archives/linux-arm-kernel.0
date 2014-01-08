From: abrestic@chromium.org (Andrew Bresticker)
Date: Wed, 8 Jan 2014 14:28:37 -0800
Subject: [PATCH 0/7] misc Tegra clock fixes
In-Reply-To: <1388105067-24438-1-git-send-email-abrestic@chromium.org>
References: <1388105067-24438-1-git-send-email-abrestic@chromium.org>
Message-ID: <CAL1qeaG0Y4__viWsZeoFdf8XFN3Wk7CO2abeEjzRZg+wNRV56w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen, Peter,

> Fixes for various clock-related issues found during bringup of
> Tegra124-based Venice2 and Norrin boards.
>
> Andrew Bresticker (3):
>   clk: tegra: fix sdmmc clks on Tegra1x4
>   clk: tegra: cclk_lp has a pllx/2 divider
>   clk: tegra: use max divider if divider overflows
>
> David Ung (1):
>   clk: tegra: PLLD2 fixes for hdmi
>
> Gabe Black (1):
>   clk: tegra: Fix PLLP rate table
>
> Mark Zhang (1):
>   clk: tegra: fix host1x clock on Tegra124
>
> Rhyland Klein (1):
>   clk: tegra: Fix PLLD mnp table
>
>  drivers/clk/tegra/clk-divider.c          |  2 +-
>  drivers/clk/tegra/clk-id.h               |  4 +++
>  drivers/clk/tegra/clk-tegra-periph.c     |  4 +++
>  drivers/clk/tegra/clk-tegra-super-gen4.c |  2 +-
>  drivers/clk/tegra/clk-tegra114.c         |  8 +++---
>  drivers/clk/tegra/clk-tegra124.c         | 46 +++++++++++++++++++-------------
>  6 files changed, 41 insertions(+), 25 deletions(-)

Any comments on this series?

Thanks!
Andrew
