From: b32955@freescale.com (Huang Shijie)
Date: Thu, 4 Jul 2013 14:39:01 +0800
Subject: mx6q boot on linux-next 20130703
In-Reply-To: <CAOMZO5DgAu2-cknESp4a675KP5gDrJxM2A_FqUgAZav83Db=fw@mail.gmail.com>
References: <CAOMZO5DgAu2-cknESp4a675KP5gDrJxM2A_FqUgAZav83Db=fw@mail.gmail.com>
Message-ID: <51D51885.3080102@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?07?04? 07:52, Fabio Estevam ??:
> Hi,
>
> I am running linux-next 20130703 on a mx6q board, and seeing a strange
> behaviour.
>
> Only if I enable DEBUG_LL + earlyprintk and disable
> CONFIG_SERIAL_FSL_LPUART (serial driver for the FSL Vybrid SoC), I am
> able to boot the kernel until the prompt.
>
> Does anyone have any suggestion?

I tested the linux-next-0625, the boot is ok.

I think this issue is caused by the common code, not the imx code.

thanks
Huang Shijie
