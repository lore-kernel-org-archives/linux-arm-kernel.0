From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 12 Jun 2012 15:53:02 -0300
Subject: ARM: iMX: lockup with irqs disabled in drivers/tty/imx.c
In-Reply-To: <4FB8CFBB.2020004@cs.bris.ac.uk>
References: <4FB8CFBB.2020004@cs.bris.ac.uk>
Message-ID: <CAOMZO5CDoJm8QgeA=r6k+hcZ-Z8sGZ19AgA1d8wWTGh3PaXmoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael,

On Sun, May 20, 2012 at 8:04 AM, Michael McTernan
<Michael.McTernan.2001@cs.bris.ac.uk> wrote:

> I can then trigger the lockup by simply booting the unit and issuing "echo >
> /dev/ttymxc1". ?The same can be done on the other ports too. Once locked,
> magic sys-req appears not to work, pinging the target is dead etc...

I did a 'echo "hello" > /dev/ttymxc1' and I am not able to see the
lockup on a mx31pdk running 3.5-rc1.
