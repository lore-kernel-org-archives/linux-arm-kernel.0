From: otavio.salvador@ossystems.com.br (Otavio Salvador)
Date: Sun, 25 Nov 2018 19:45:12 -0200
Subject: [PATCH v2 1/3] ARM: imx_v6_v7_defconfig: Remove explicit
 ARM_UNWIND disable
In-Reply-To: <CAK8P3a2FXsz4-fBvUuQ6J5ERDkK6QsBoKvLLsDsczZqCOrq3Kw@mail.gmail.com>
References: <20181125212159.11590-1-otavio@ossystems.com.br>
 <CAK8P3a2FXsz4-fBvUuQ6J5ERDkK6QsBoKvLLsDsczZqCOrq3Kw@mail.gmail.com>
Message-ID: <CAP9ODKqDySwsJ+3hJFXYfm8NyhsVGDwyRi+3sUUJiP304SU07g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 25, 2018 at 7:35 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Sun, Nov 25, 2018 at 10:24 PM Otavio Salvador
> <otavio@ossystems.com.br> wrote:
> >
> > CONFIG_ARM_UNWIND is removed when running 'savedefconfig', but
> > selected by the Kconfig logic.  This is done in preparation to making
> > further changes to this defconfig cleaner.
> >
>
> Does this mean we no longer get the unwinder, or there is some other
> config (which?) that unconditionally selects it?

It is selected. Before changing the defconfig I did a savedefconfig to
avoid unrelated changes to be included on the subsequent patches and
then I found it was now selected.

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9 9981-7854          Mobile: +1 (347) 903-9750
