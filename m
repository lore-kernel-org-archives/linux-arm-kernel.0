From: b32955@freescale.com (Huang Shijie)
Date: Wed, 17 Jul 2013 15:28:48 +0800
Subject: [PATCH v2] serial: imx: remove the uart_console() check
In-Reply-To: <20130701160833.GC14172@S2101-09.ap.freescale.net>
References: <1372397982-19017-1-git-send-email-b32955@freescale.com>
 <20130701160833.GC14172@S2101-09.ap.freescale.net>
Message-ID: <51E647B0.7010509@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?07?02? 00:08, Shawn Guo ??:
> On Fri, Jun 28, 2013 at 01:39:42PM +0800, Huang Shijie wrote:
>> The uart_console() check makes the clocks(clk_per and clk_ipg) opened
>> even when we close the console uart.
>>
>> This patch enable/disable the clocks in imx_console_write(),
>> so we can keep the clocks closed when the console uart is closed.
>>
>> Also remove the clock enable/disable oprations in the probe, we do not
>> need them any more.
>>
>> Signed-off-by: Huang Shijie<b32955@freescale.com>
> Acked-by: Shawn Guo<shawn.guo@linaro.org>
Hi Greg:
could you merge this patch?

thanks
Huang Shijie
