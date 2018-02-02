From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 2 Feb 2018 19:23:20 +0530
Subject: [PATCH v6 18/41] clk: davinci: New driver for TI DA8XX CFGCHIP
 clocks
In-Reply-To: <c2138795-edcd-bb7d-094d-47dc049c33df@ti.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-19-git-send-email-david@lechnology.com>
 <c2138795-edcd-bb7d-094d-47dc049c33df@ti.com>
Message-ID: <9f3640de-461e-de42-30ab-c1089f9dbc43@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 February 2018 06:49 PM, Sekhar Nori wrote:
> On Saturday 20 January 2018 10:43 PM, David Lechner wrote:
>> +static const struct clk_ops da8xx_cfgchip_div4p5_clk_ops = {
>> +	.enable		= da8xx_cfgchip_gate_clk_enable,
>> +	.disable	= da8xx_cfgchip_gate_clk_disable,
>> +	.is_enabled	= da8xx_cfgchip_gate_clk_is_enabled,
> 
> I assume the reason for not using clk-gate.c is lack of regmap support
> there?

This is rather question for da8xx_cfgchip_gate_clk_ops. Sorry about the
bad context.

Thanks,
Sekhar
