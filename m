From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 23 Mar 2015 16:55:57 +0100
Subject: [PATCH 2/5] USB: host: ohci-at91: remove useless uclk clock
In-Reply-To: <Pine.LNX.4.44L0.1503171501110.1061-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1503171501110.1061-100000@iolanthe.rowland.org>
Message-ID: <5510378D.9060009@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 17/03/2015 20:02, Alan Stern a ?crit :
> On Tue, 17 Mar 2015, Boris Brezillon wrote:
> 
>> Now that the system clock driver is forwarding set_rate request to the
>> parent clock, we can safely call clk_set_rate on the system clk and get
>> rid of the uclk field.
>>
>> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Hi Alan,

As I don't have any other "drivers" patch for 4.1, would you mind taking
this patch with your tree?
I'll take care of the remaining ones dealing with Device Tree: they are
independent anyway.

Thanks, bye.
-- 
Nicolas Ferre
