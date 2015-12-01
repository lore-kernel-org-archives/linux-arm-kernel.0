From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Tue, 1 Dec 2015 10:53:24 +0100
Subject: [PATCH v2 4/9] pinctrl: Add support STM32 MCUs
In-Reply-To: <1445102604-11502-5-git-send-email-mcoquelin.stm32@gmail.com>
References: <1445102604-11502-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1445102604-11502-5-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <CALszF6Cd=yei0m2Zs=+k=KT5RUzdesGWPK7PAQPdj_-Ouan=2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

2015-10-17 19:23 GMT+02:00 Maxime Coquelin <mcoquelin.stm32@gmail.com>:
> This patch adds pinctrl and GPIO support to STMicroelectronic's STM32
> family of MCUs.
>
> While it only supports STM32F429 for now, it has been designed to enable
> support of other MCUs of the family (e.g. STM32F746).
>
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> ---
>  drivers/pinctrl/Kconfig                   |    1 +
>  drivers/pinctrl/Makefile                  |    1 +
>  drivers/pinctrl/stm32/Kconfig             |   16 +
>  drivers/pinctrl/stm32/Makefile            |    5 +
>  drivers/pinctrl/stm32/pinctrl-stm32.c     |  856 +++++++++++++++
>  drivers/pinctrl/stm32/pinctrl-stm32.h     |   43 +
>  drivers/pinctrl/stm32/pinctrl-stm32f429.c | 1598 +++++++++++++++++++++++++++++
>  7 files changed, 2520 insertions(+)
>  create mode 100644 drivers/pinctrl/stm32/Kconfig
>  create mode 100644 drivers/pinctrl/stm32/Makefile
>  create mode 100644 drivers/pinctrl/stm32/pinctrl-stm32.c
>  create mode 100644 drivers/pinctrl/stm32/pinctrl-stm32.h
>  create mode 100644 drivers/pinctrl/stm32/pinctrl-stm32f429.c
>

Gentle reminder, do you know when you will be able to review this driver?

Thanks in advance,
Maxime
