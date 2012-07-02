From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 2 Jul 2012 15:55:28 +0800
Subject: [GIT PULL] prima2 GPIO support in pinmux
In-Reply-To: <CAGsJ_4xrk0w5aQy+ZSYZwQ3pW5My7dcHnDX57+985VTbdHXCzg@mail.gmail.com>
References: <CAGsJ_4xrk0w5aQy+ZSYZwQ3pW5My7dcHnDX57+985VTbdHXCzg@mail.gmail.com>
Message-ID: <CAGsJ_4xcJCdt=wjNt6pcH1uQg+uHcsScDDtQvgNVRtsosPi=kg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Note this has been acked by Linus Walleij, he suggested to go through
prima2 arm-soc.

-barry

2012/7/2 Barry Song <21cnbao@gmail.com>:
> Hi Olof, Arnd,
>
> Please pull the following GPIO support in pinmux for 3.6.
>
> Regards,
> Barry
>
> The following changes since commit ca24a145573124732152daff105ba68cc9a2b545:
>
>   Merge branch 'fixes' of git://git.linaro.org/people/rmk/linux-arm
> (2012-07-01 11:02:25 -0700)
>
> are available in the git repository at:
>
>   git://gitorious.org/sirfprima2-kernel/sirfprima2-kernel.git prima2/drivers
>
> Barry Song (1):
>       PINCTRL: SiRF: add GPIO and GPIO irq support in CSR SiRFprimaII
>
>  arch/arm/Kconfig                         |    1 +
>  arch/arm/mach-prima2/include/mach/gpio.h |   13 +
>  arch/arm/mach-prima2/include/mach/irqs.h |    2 +-
>  drivers/pinctrl/pinctrl-sirf.c           |  489
> +++++++++++++++++++++++++++++-
>  4 files changed, 503 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/mach-prima2/include/mach/gpio.h
>
>
