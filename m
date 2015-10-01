From: john.stultz@linaro.org (John Stultz)
Date: Thu, 1 Oct 2015 15:20:18 -0700
Subject: [RFC/PATCH 09/11] clocksource: add TI 32.768 Hz counter driver
In-Reply-To: <1443559446-26969-10-git-send-email-balbi@ti.com>
References: <1443559446-26969-1-git-send-email-balbi@ti.com>
 <1443559446-26969-10-git-send-email-balbi@ti.com>
Message-ID: <CALAqxLVUDYivs4QKWtFDbwFdWqa2JJX49Aj15p69zpYCb1_SbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 29, 2015 at 1:44 PM, Felipe Balbi <balbi@ti.com> wrote:
> Introduce a new clocksource driver for Texas
> Instruments 32.768 Hz device which is available
> on most OMAP-like devices.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/clocksource/Kconfig        |   8 +++
>  drivers/clocksource/Makefile       |   1 +
>  drivers/clocksource/timer-ti-32k.c | 121 +++++++++++++++++++++++++++++++++++++

Also isn't this somewhat duplicate of the code in
arch/arm/plat-omap/counter_32k.c ?

Was this really a rewrite or just a code migration? Should you
preserve the copyrights from counter_32k.c?

thanks
-john
