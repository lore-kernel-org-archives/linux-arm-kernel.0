From: shubhrajyoti@ti.com (Shubhrajyoti)
Date: Mon, 22 Oct 2012 20:32:01 +0530
Subject: [PATCH 0/8] I2C patches for v3.8 merge window
In-Reply-To: <20121022140658.GA18993@arwen.pp.htv.fi>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
 <20121022133023.GC14033@arwen.pp.htv.fi>
 <CAM=Q2ctS3hxngk5efcvScAdv-2GtH2pHRZoxRhRTiOWmQA-AXw@mail.gmail.com>
 <20121022140658.GA18993@arwen.pp.htv.fi>
Message-ID: <50855FE9.6000806@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 22 October 2012 07:36 PM, Felipe Balbi wrote:
> can you also check if echo mem > /sys/power/state works ? Don't forget
> to enable UART wakeups with:
>
> echo enabled > /sys/devices/platform/omap_uart.2/power/wakeup
> echo enabled > /sys/devices/platform/omap_uart.2/tty/ttyO2/power/wakeup
>
> before trying to suspend. Another cool test is rtctest (since our RTC is
> part of TWL). It worked fine on my two platforms. Attached you will find
> the sourcecode for rtctest.
On omap3 tested . with off hitting both in suspend and idle path.


Also with rtcwake.

Thanks
