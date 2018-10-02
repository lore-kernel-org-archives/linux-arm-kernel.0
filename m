From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 2 Oct 2018 11:19:23 +0200
Subject: [GIT PULL] arm: actions: dt64 for v4.20 #1
In-Reply-To: <20180930180715.25829-2-afaerber@suse.de>
References: <20180930180715.25829-1-afaerber@suse.de>
 <20180930180715.25829-2-afaerber@suse.de>
Message-ID: <CAK8P3a3piYDWEPGUZsbcBM2=hbLOrHyuXeY8BSr_d92eNSRXCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 30, 2018 at 8:07 PM Andreas F?rber <afaerber@suse.de> wrote:

>
>   git://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git tags/actions-arm64-dt-for-4.20
>
> for you to fetch changes up to 01463ac63b53e24e4e315aa9c5f091e9e0342ad4:
>
>   arm64: dts: actions: s700: Set UART clock references from CMU (2018-09-30 18:57:23 +0200)
>
> ----------------------------------------------------------------
> Actions Semi arm64 based SoC DT for v4.20
>
> This updates SPDX headers for remaining files.
>
> For S900 it adds clock, pinctrl, i2c and dma nodes.
> S900 SPS is added via topic branch (shared with driver).
>
> For S700 it adds clock nodes.

Pulled into next/dt, thanks!

        Arnd
