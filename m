From: olivier.barthel@gmail.com (Olivier Barthel)
Date: Thu, 2 Sep 2010 07:42:36 +0200
Subject: imx.c : dte mode and modem control
Message-ID: <AANLkTi=jrVQAnzr6PAMU_Ycenhjp7_Aww-x=769VdOEN@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
I use i.MX25 uart to communicate with a modem (PSTN or GSM/GPRS). The
DCD, DTR and RI signals are used. On our board, these signals are used
on iMX25 with DTE mode (i.MX25 DTR is an output). imx.c does not
support modem signals and DTE mode. These features existed in the file
mxc_uart.c who was present in the freescale bsp until 2.6.28. Is it
planned to integrate these features into imx.c ?
Regards
Olivier
