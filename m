From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Mon, 18 May 2015 15:05:57 +0200
Subject: [PATCH v8 11/16] serial: stm32-usart: Add STM32 USART Driver
In-Reply-To: <1431158038-3813-12-git-send-email-mcoquelin.stm32@gmail.com>
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1431158038-3813-12-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <CALszF6CfF9a37p7Gy=i8+NJ4EenaO2n1MQ=zc2ORdLf=9ktdZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

2015-05-09 9:53 GMT+02:00 Maxime Coquelin <mcoquelin.stm32@gmail.com>:
> This drivers adds support to the STM32 USART controller, which is a
> standard serial driver.
>
> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
> Reviewed-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> ---
>  drivers/tty/serial/Kconfig       |  17 +
>  drivers/tty/serial/Makefile      |   1 +
>  drivers/tty/serial/stm32-usart.c | 739 +++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/serial_core.h |   3 +
>  4 files changed, 760 insertions(+)
>  create mode 100644 drivers/tty/serial/stm32-usart.c
>

Could you consider applying this patch and the one documenting its DT
bindings (patch 10/16) to your tree for 4.2?

Thanks in advance,
Maxime
