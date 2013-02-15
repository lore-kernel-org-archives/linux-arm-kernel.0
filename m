From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Fri, 15 Feb 2013 07:18:05 +0100
Subject: [PATCH v6 09/10] clk: tegra: Implement clocks for Tegra114
In-Reply-To: <1360580700-10245-10-git-send-email-pdeschrijver@nvidia.com>
References: <1360580700-10245-1-git-send-email-pdeschrijver@nvidia.com><1360580700-10245-10-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <20130215.081805.2193798170330624846.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter De Schrijver <pdeschrijver@nvidia.com> wrote @ Mon, 11 Feb 2013 12:04:59 +0100:

> +enum tegra114_clk {
> +       rtc = 4, timer = 5, uarta = 6, sdmmc2 = 9, i2s1 = 11, i2c1 = 12,

Why no 'cpu = 0' here?
