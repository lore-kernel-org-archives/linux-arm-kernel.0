From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 5 Jan 2018 17:07:02 +0100
Subject: [GIT PULL] ARM: aspeed: dts changes for 4.16
In-Reply-To: <CACPK8XdOywvpyWqgOG6TVj4EwBqWA7yCmzaNqGQyvQJzPuseSg@mail.gmail.com>
References: <CACPK8XdOywvpyWqgOG6TVj4EwBqWA7yCmzaNqGQyvQJzPuseSg@mail.gmail.com>
Message-ID: <CAK8P3a3uazmmLZP6dk2LD9yAXKOqeJfUD2vQbu8zQxWoOU=8vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 3, 2018 at 5:17 AM, Joel Stanley <joel@jms.id.au> wrote:

> ----------------------------------------------------------------
> ASPEED device tree updates for 4.16
>
> Clock driver support:
>
>  Rework all platforms to use proper clock bindings. Linux should now boot
>  upstream kernels on ast2400 and ast2500 platforms without out of tree
>  patches.
>
> New systems:
>
>  Witherspoon: OpenPower Power9 server manufactured by IBM that uses
> the ASPEED ast2500
>  Zaius: OpenPower Power9 server manufactured by Invatech that uses the
> ASPEED ast2500
>  Q71L: Intel Xeon server manufactured by Qanta that uses the ASPEED ast2400
>
>  We also see updates to the Palmetto and Romulus systems to bring them in
>  line with the functionality of those above.
>
>  The systems take advantage of recently added drivers for LPC Snoop
>  device and the PWM/Tachometer fan controller.
>
> OpenBMC flash layout:
>
>  The flash layout used OpenBMC systems is added and the device trees now
>  use it.

Pulled into next/dt, thanks!

       Arnd
