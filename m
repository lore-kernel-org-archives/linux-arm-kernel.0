From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 26 Jun 2015 11:13:47 +0200
Subject: [PATCH v3 0/2] add support holding 24Mhz osc during suspend
In-Reply-To: <1435064020-7057-1-git-send-email-zyw@rock-chips.com>
References: <1435064020-7057-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1819327.FqTWPKx08f@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 23. Juni 2015, 20:53:38 schrieb Chris Zhong:
> Since the usb-phy clocks are not connected to the 32khz clock-in, they
> only have 24Mhz as the clock source. If we want to wake up system via
> usb device, we should hold the 24Mhz osc during suspend.
> This Patch has tested on chromebook jerry board, with another patch[0],
> we can wakeup system via usb keyboard.
> 
> [0] https://chromium-review.googlesource.com/#/c/277811/3

applied both to my soc branch for 4.3
