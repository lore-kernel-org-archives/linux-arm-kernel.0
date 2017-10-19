From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Oct 2017 23:49:50 +0200
Subject: [GIT PULL] ARM: dts: aspeed: Changes for v4.15
In-Reply-To: <CACPK8XdG=wjKuAJJ7yzu320UPxKAGA-A2DYtrL5=CwCN2DNpBg@mail.gmail.com>
References: <CACPK8XdG=wjKuAJJ7yzu320UPxKAGA-A2DYtrL5=CwCN2DNpBg@mail.gmail.com>
Message-ID: <CAK8P3a1PNhysyCne-7CihaFucUvz7_ccWOzJjihsi3y_CjgEDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 6, 2017 at 9:05 AM, Joel Stanley <joel@jms.id.au> wrote:
> Hello ARM SoC maintainers!
>
> Here are some ASPEED device tree updates for v4.15.
>
> Sadly our clk driver is still under review, so I have not been able to
> include all of the patches I intended to. Alas, these improvements are
> still useful.

Pulled into next/dt

>     ARM: dts: aspeed: Add aliases for UARTs

Can you explain this one? It looks like you now have aliases for
all uart and i2c entries on all machines, even when they don't
actually expose the ports. The purpose of the aliases is to
only list the ones that are actually usable, so they should normally
go into the board specific .dts files.

     Arnd
