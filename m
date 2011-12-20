From: olof@lixom.net (Olof Johansson)
Date: Mon, 19 Dec 2011 21:33:50 -0800
Subject: [GIT PULL] omap uart runtime PM support for v3.2 merge window
In-Reply-To: <20111219201018.GT6464@atomide.com>
References: <20111219201018.GT6464@atomide.com>
Message-ID: <CAOesGMjjOBeVmtX=eSrUx1Ur4PbnybgW9t1eV7PrR9dNv-ZtRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 19, 2011 at 12:10 PM, Tony Lindgren <tony@atomide.com> wrote:
> Hi Arnd & Olof,
>
> Please pull omap uart changes from:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap uart
>
> These allow us to remove quite a bit of serial port code
> from arch/arm/*omap* as the omap-serial.c driver can now do
> the necessary things using runtime PM :) Also this series
> changes omap board-generic.c to use DT for the serial port.
>
> The changes to drivers/tty/serial/omap-serial.c have been
> agreed to be merged via omap patches in the following thread:
>
> http://www.spinics.net/lists/linux-serial/msg05145.html

Thanks, pulled into next/pm.


-Olof
