From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Tue, 5 Feb 2013 11:50:48 +0100
Subject: [PATCH V2] clk: Add composite clock type
In-Reply-To: <1359965482-29655-1-git-send-email-pgaikwad@nvidia.com>
References: <1359965482-29655-1-git-send-email-pgaikwad@nvidia.com>
Message-ID: <20130205.125048.1813250873129029298.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prashant Gaikwad <pgaikwad@nvidia.com> wrote @ Mon, 4 Feb 2013 09:11:22 +0100:
...
If you want to consider the consistency for the other tegra
clk_register(), the following comment can be added although this is a
common function.

+	/* Data in .init is copied by clk_register(), so stack variable OK */
> +       composite->hw.init = &init;
> +
> +       clk = clk_register(dev, &composite->hw);
