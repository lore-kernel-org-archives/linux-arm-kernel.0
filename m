From: olof@lixom.net (Olof Johansson)
Date: Tue, 28 May 2013 16:24:15 -0700
Subject: [PATCH] ARM: EXYNOS: Update defconfig for Arndale and Origen board
In-Reply-To: <1368168599-28507-1-git-send-email-tushar.behera@linaro.org>
References: <1368168599-28507-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <CAOesGMjirb0h4kZ1hB9=1JnDV+azTEG=_6RR9v000xbMsvuv2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, May 9, 2013 at 11:49 PM, Tushar Behera <tushar.behera@linaro.org> wrote:
> It updates following drivers for EXYNOS based DT platform.
>
> * S5M8767 driver
> * MAX8997 driver
> * MMC SDHCI driver
>
> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>

I didn't see any movement from Kukjin on this, so I have (tentatively)
applied this together with my base defconfig update to the fixes
branch of arm-soc. I'll take it out in case he protests, but it's very
useful since the simplefb driver has landed in 3.10-rc3.


-Olof
