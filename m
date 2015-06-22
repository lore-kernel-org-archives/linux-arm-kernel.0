From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 22 Jun 2015 10:46:00 -0300
Subject: [PATCH] ARM: imx6: Fix "BUG: scheduling while atomic" if PCIe
 switch is attached
In-Reply-To: <1434980241.3014.16.camel@pengutronix.de>
References: <1434614214-2085-1-git-send-email-dave.mueller@gmx.ch>
 <1434616021.3061.2.camel@pengutronix.de>
 <CAOMZO5BLQXKwVjykQVVmD1kHHm=M31RJPmgGa1Tznz8gpYwvyw@mail.gmail.com>
 <1434980241.3014.16.camel@pengutronix.de>
Message-ID: <CAOMZO5DRQBZKXA3NZMGEEms6Na9=Z_N9ta6YFNU0zbJZu7Od1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 22, 2015 at 10:37 AM, Lucas Stach <l.stach@pengutronix.de> wrote:

> mdelay(2) is completely reasonable. Note the difference between delay
> and sleep.

Oh, that's right :-)

Thanks
