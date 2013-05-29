From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 29 May 2013 11:34:07 -0700
Subject: [PATCH] ARM: EXYNOS: Update defconfig for Arndale and Origen board
In-Reply-To: <51A57D39.8030506@linaro.org> (Tushar Behera's message of "Wed,
 29 May 2013 09:29:53 +0530")
References: <1368168599-28507-1-git-send-email-tushar.behera@linaro.org>
 <87sj1qzaov.fsf@linaro.org> <5191AA89.6010901@linaro.org>
 <20130528231740.GA28879@quad.lixom.net> <51A57D39.8030506@linaro.org>
Message-ID: <87mwrd63fk.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tushar Behera <tushar.behera@linaro.org> writes:

[...]

> The patches are at [1]. There are a total of 6 patches on top of
> v3.10-rc3. 3 of them (a, b, d) are queued for 3.10-rc4 and another patch
> (c) is just a defconfig hack to get Arndale booting. Remaining 2 patches
> (e, f) are required to reset the hub during EHCI initialization.
>
> a. ARM: exynos: defconfig update
> b. ARM: EXYNOS: Update defconfig for Arndale and Origen board
> c. [TEMP] ARM: EXYNOS: Set low-level UART port to 2
> d. ARM: dts: Enabling samsung-usb2phy driver for exynos5250
> e. usb: ehci-s5p: add the HSIC port initialization
> f. ARM: dts: Add USB gpio entries for Arndale board
>
> I am not sure whether such kind of board-specific patches (e, f) are
> appreciated in the drivers. But that is all we need to get USB and
> Ethernet to work on v3.10-rc3 kernel.

I confirm that using v3.10-rc3 + these patches, the wired network is
working on Arndale.

Thanks,

Kevin
