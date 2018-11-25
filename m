From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 25 Nov 2018 22:35:10 +0100
Subject: [PATCH v2 1/3] ARM: imx_v6_v7_defconfig: Remove explicit
 ARM_UNWIND disable
In-Reply-To: <20181125212159.11590-1-otavio@ossystems.com.br>
References: <20181125212159.11590-1-otavio@ossystems.com.br>
Message-ID: <CAK8P3a2FXsz4-fBvUuQ6J5ERDkK6QsBoKvLLsDsczZqCOrq3Kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 25, 2018 at 10:24 PM Otavio Salvador
<otavio@ossystems.com.br> wrote:
>
> CONFIG_ARM_UNWIND is removed when running 'savedefconfig', but
> selected by the Kconfig logic.  This is done in preparation to making
> further changes to this defconfig cleaner.
>

Does this mean we no longer get the unwinder, or there is some other
config (which?) that unconditionally selects it?

      Arnd
