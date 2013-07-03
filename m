From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 3 Jul 2013 20:52:47 -0300
Subject: mx6q boot on linux-next 20130703
Message-ID: <CAOMZO5DgAu2-cknESp4a675KP5gDrJxM2A_FqUgAZav83Db=fw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am running linux-next 20130703 on a mx6q board, and seeing a strange
behaviour.

Only if I enable DEBUG_LL + earlyprintk and disable
CONFIG_SERIAL_FSL_LPUART (serial driver for the FSL Vybrid SoC), I am
able to boot the kernel until the prompt.

Does anyone have any suggestion?

Regards,

Fabio Estevam
