From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 23 Jan 2017 15:53:47 -0800
Subject: [PATCHv4 1/5] clk: mvebu: support for 98DX3236 SoC
In-Reply-To: <be295fd327674a2ca91437456db7a047@svr-chch-ex1.atlnz.lc>
References: <20170113091222.7132-1-chris.packham@alliedtelesis.co.nz>
 <20170113091222.7132-2-chris.packham@alliedtelesis.co.nz>
 <20170121004819.GA8801@codeaurora.org>
 <be295fd327674a2ca91437456db7a047@svr-chch-ex1.atlnz.lc>
Message-ID: <bf402123-52f5-51ee-32df-276ed7a7e832@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/22/2017 11:53 PM, Chris Packham wrote:
> Not 100% sure what you mean. Something like this?
>
> +static void __init of_mv98dx3236_cpu_clk_setup(struct device_node *node)
> +{
> +       of_clk_add_provider(node, of_clk_src_simple_get, NULL);
> +}
>
> Seems to work as expected (i.e. does nothing, kernel boots/runs).
>

Yep that's what I mean.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
