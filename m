From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 27 Mar 2018 15:00:13 +0200
Subject: [GIT PULL 2/3] omap dts changes for v4.17, part 2
In-Reply-To: <pull-1521736966-849602@atomide.com-2>
References: <pull-1521736966-849602@atomide.com>
 <pull-1521736966-849602@atomide.com-2>
Message-ID: <CAK8P3a2GapVk1PeiyFt59hhAZV28vLYd3q-SZrVJfDhct9nKdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 22, 2018 at 5:43 PM, Tony Lindgren <tony@atomide.com> wrote:
> Second set of dts changes for omap variants for v4.17
>
> This series of patches configures few new drivers and adds
> omap5 specific nodes:
>
> - Enable USB OTG mode for xhci on am437x
>
> - A series of changes to configure aux control module instance
>   on omap5 mostly to get the audio clocks configured
>
> - A series of changes to update droid4 for MDM6600 modem USB PHY
>   and UART1 pinctrl

Pulled into next/dt, thanks!

        Arnd
