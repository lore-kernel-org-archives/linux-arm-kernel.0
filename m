From: skannan@codeaurora.org (Saravana Kannan)
Date: Mon, 14 Feb 2011 22:31:11 -0800
Subject: [RFC,PATCH 2/3] clk: Generic support for fixed-rate clocks
In-Reply-To: <201102151418.37780.jeremy.kerr@canonical.com>
References: <1297233693.242725.820672531799.2.gpush@pororo>	<201102150941.00668.jeremy.kerr@canonical.com>	<4D5A063F.1010102@codeaurora.org>
	<201102151418.37780.jeremy.kerr@canonical.com>
Message-ID: <4D5A1DAF.5050302@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/14/2011 10:18 PM, Jeremy Kerr wrote:

> Because the drivers using this clock don't know that it's a fixed clock.
>
> For example, a uart needs to know the rate of its clock source, so that it can
> set its internal divisors to get a valid baud rate. The uart driver will query
> the input rate using clk_get_rate(). The driver still needs to call
> clk_enable/clk_prepare/etc, because on some systems it may have a switchable
> clock.

Thanks. Makes sense.

-Saravana
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
