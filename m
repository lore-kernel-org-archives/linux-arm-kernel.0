From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 13 Apr 2012 16:56:28 +0800
Subject: [PATCH] clk: Allocate and add clock lookups from clk_register()
In-Reply-To: <9fa570d09d94cdc4892b4e413ef3a0edc6f9dcef.1334298848.git.viresh.kumar@st.com>
References: <9fa570d09d94cdc4892b4e413ef3a0edc6f9dcef.1334298848.git.viresh.kumar@st.com>
Message-ID: <20120413085627.GD27730@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>  struct clk *clk_register(struct device *dev, const char *name,
>  		const struct clk_ops *ops, struct clk_hw *hw,
> -		const char **parent_names, u8 num_parents, unsigned long flags)
> +		const char **parent_names, u8 num_parents, unsigned long flags,
> +		struct clk_lookup **cl, const char *dev_id, const char *con_id)
10 arguments. It worths to use a struct ? 

Thanks
Richard
