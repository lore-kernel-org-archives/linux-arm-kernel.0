From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 5 Oct 2018 17:46:45 +0200
Subject: [PATCH] arm64: defconfig: Enable TI_SCI related configs
In-Reply-To: <20181005150350.yj7irr6z4yaff3m7@kahuna>
References: <20181005100330.16914-1-lokeshvutla@ti.com>
 <20181005150350.yj7irr6z4yaff3m7@kahuna>
Message-ID: <CAK8P3a1xq7sRb=N3mynzVcVEPXeBHYC6aw-FoXGOj54m7aK9ZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 5, 2018 at 5:03 PM Nishanth Menon <nm@ti.com> wrote:
>
> On 10:03-20181005, Lokesh Vutla wrote:
> > Enable TI System Control Interface (TI_SCI) Message Protocol library
> > and it's relevant power management drivers using this library.
> >
> > TI's AM6 SoC uses this TI_SCI library to communicate to its system
> > controller(DMSC). While at it, enable TI_MESSAGE_MANAGER mailbox driver
> > using which this communication happens.
> >
> > Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>

>
> Olof, any chance to pick this up for v4.20?
>
> Acked-by: Nishanth Menon <nm@ti.com>
>

Applied to next/defconfig, thanks!

       Arnd
