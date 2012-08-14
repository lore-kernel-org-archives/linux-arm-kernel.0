From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 14 Aug 2012 14:46:16 +0800
Subject: How to define gpio irq with device tree
In-Reply-To: <5029E646.5090900@gmail.com>
References: <5024FF03.1070805@de.bosch.com>
 <20120814041841.GA30782@S2101-09.ap.freescale.net>
 <5029E646.5090900@gmail.com>
Message-ID: <20120814064614.GA2734@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 14, 2012 at 01:46:46PM +0800, Hui Wang wrote:
> I generated a similar patch on the last week, only the linux-input
> part. please refer to https://patchwork.kernel.org/patch/1293451/
> 
Ok.  But can you rename property "irq-gpio" to "wakeup-gpios"?
Firstly, the idiom of gpio naming in DT is *-gpios, even though
most of time, it could be just one gpio.  Secondly, as the pin is
accessed as a gpio only in egalax_wake_up_device for waking up the
device, "wakeup-gpios" sounds better?

-- 
Regards,
Shawn
