From: roel.kluin@gmail.com (roel kluin)
Date: Tue, 2 Feb 2010 16:41:24 +0100
Subject: [PATCH v3 2/7 RE-SEND] ARM: S5P6442: Add clock support for
	S5P6442
In-Reply-To: <1265116976-10140-1-git-send-email-kgene.kim@samsung.com>
References: <1265116976-10140-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <25e057c01002020741l157f57e3s431716adcf038a83@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This patch adds clock support for S5P6442. This patch adds the clock
> register definitions and the various system clocks in S5P6442.

> +static struct clksrc_clk clk_mout_epll = {
> + ? ? ? .clk ? ?= {
> + ? ? ? ? ? ? ? .name ? ? ? ? ? = "mout_epll",
> + ? ? ? ? ? ? ? .id ? ? ? ? ? ? = -1,
> + ? ? ? },
> + ? ? ? .sources ? ? ? ?= &clk_src_epll,
> + ? ? ? .reg_src ? ? ? ?= { .reg = S5P_CLK_SRC0, .shift = 8, .size = 1 },
> +};

This appears not to be used, is this implemented in another patch?

Roel
