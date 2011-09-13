From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 13 Sep 2011 12:03:33 -0700
Subject: [PATCH 05/11] clk: Prototype and document clk_register()
In-Reply-To: <1314191759-16941-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20110824131324.GB16520@opensource.wolfsonmicro.com>
	<1314191759-16941-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1314191759-16941-5-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <4E6FA905.8090905@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/24/11 06:15, Mark Brown wrote:
> @@ -136,6 +136,18 @@ extern struct clk_hw_ops clk_gate_ops;
>  
>  #endif /* CONFIG_GENERIC_CLK_GATE */
>  
> +/**
> + * clk_register - register and initialize a new clock
> + *
> + * @ops: ops for the new clock
> + * @hw: struct clk_hw to be passed to the ops of the new clock
> + * @name: name to use for the new clock
> + *
> + * Register a new clock with the clk subsytem.  Returns either a

s/subsytem/subsystem/

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
