From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 13 May 2013 17:06:56 -0700
Subject: [PATCH] ARM: EXYNOS: Update defconfig for Arndale and Origen board
In-Reply-To: <1368168599-28507-1-git-send-email-tushar.behera@linaro.org>
 (Tushar Behera's message of "Fri, 10 May 2013 12:19:59 +0530")
References: <1368168599-28507-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <87sj1qzaov.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tushar Behera <tushar.behera@linaro.org> writes:

> It updates following drivers for EXYNOS based DT platform.
>
> * S5M8767 driver
> * MAX8997 driver
> * MMC SDHCI driver
>
> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>

I tested this using v3.10-rc1 on Arndale, but still don't get any
support for the wired network.  Do you know if this is a Kconfig issue,
or a missing driver?

I suspect it may be related to the various "unable to find transceiver
of type USB2 PHY" messages I'm seeing?

Thanks,

Kevin
