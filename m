From: abrestic@chromium.org (Andrew Bresticker)
Date: Thu, 17 Oct 2013 16:44:41 -0700
Subject: [PATCH v4 10/15] clk: tegra: move audio clk to common file
In-Reply-To: <1382013526-12800-11-git-send-email-pdeschrijver@nvidia.com>
References: <1382013526-12800-1-git-send-email-pdeschrijver@nvidia.com>
 <1382013526-12800-11-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <CAL1qeaFeUevACE_ETqV7Ytzi2mk5bPANzfEAQ0uLWmw=iGELTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

> +static struct tegra_clk tegra114_clks[tegra_clk_max] __initdata = {

Not really a big deal, but a lot of these clocks are not audio
related.  Maybe they should be added when the common infrastructure to
deal with them is added?

Thanks,
Andrew
