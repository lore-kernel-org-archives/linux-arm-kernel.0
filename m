From: olof@lixom.net (Olof Johansson)
Date: Tue, 23 Jul 2013 12:18:33 -0700
Subject: [PATCH] ARM: multi_v7_defconfig: Select USB chipidea driver
In-Reply-To: <1374598926-23761-1-git-send-email-fabio.estevam@freescale.com>
References: <1374598926-23761-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20130723191833.GA16811@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 23, 2013 at 02:02:06PM -0300, Fabio Estevam wrote:
> CONFIG_USB_EHCI_MXC selects the old i.mx USB driver, which does not support 
> device tree.
> 
> Select the USB chipidea driver instead, so that USB can be functional on i.mx.

Applied to 3.11 fixes branch, but we should probably stop updating defconfigs
for 3.11 now unless it's because of real problems.


-Olof
