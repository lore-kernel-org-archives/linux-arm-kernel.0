From: skannan@codeaurora.org (Saravana Kannan)
Date: Mon, 14 Feb 2011 20:51:11 -0800
Subject: [RFC,PATCH 2/3] clk: Generic support for fixed-rate clocks
In-Reply-To: <201102150941.00668.jeremy.kerr@canonical.com>
References: <1297233693.242725.820672531799.2.gpush@pororo>	<4D54738C.80900@bluewatersys.com>
	<201102150941.00668.jeremy.kerr@canonical.com>
Message-ID: <4D5A063F.1010102@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/14/2011 05:41 PM, Jeremy Kerr wrote:
> Hi Ryan,
>
>> A fixed clock may still have other operations such as enable/disable.
>
> Then it's not a fixed clock; I'd prefer this to be a separate type, as it's
> now hardware dependent.
>

I'm confused. If a clock's rate can't be changed and it can't be enabled 
or disabled, then what's the point of representing that clock 
signal/line as a clock in the driver. Seems like a "nothing to see here, 
move along" type of clock. To express it differently, I find this 
similar to "if (1) { ... }". Obviously I'm missing something here. What 
is it?

-Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
