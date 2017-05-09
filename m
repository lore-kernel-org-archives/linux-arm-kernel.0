From: dinguyen@kernel.org (Dinh Nguyen)
Date: Tue, 9 May 2017 08:38:29 -0500
Subject: [PATCH] ARM: dts: socfpga: Fix the ethernet clock phandle
In-Reply-To: <20170504102720.10545-1-marex@denx.de>
References: <20170504102720.10545-1-marex@denx.de>
Message-ID: <0309a113-c7f1-f977-d392-478c47b67e11@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/04/2017 05:27 AM, Marek Vasut wrote:
> The ethernet block clock phandle must point to the clock node which
> represents the clock which directly supply the ethernet block. This
> is emac_x_clk , not emacx_clk , so fix this.
> 
> From: Pavel Machek <pavel@denx.de>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---

Thanks for fixing this! Applied...

Dinh
