From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 15 Jan 2018 15:45:24 +0100
Subject: [PATCH v2] ARM: dts: rename oxnas dts files
In-Reply-To: <20180113173553.GA30727@makrotopia.org>
References: <20180113173553.GA30727@makrotopia.org>
Message-ID: <CAK8P3a1NUww8pGWr=gvxSDk4p7Emoq9NJyGfs8N86bU_sqgnpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 13, 2018 at 6:35 PM, Daniel Golle <daniel@makrotopia.org> wrote:
> Other platforms' device-tree files start with a platform prefix, such as
> sun7i-a20-*.dts or at91-*.dts.
> This naming scheme turns out to be handy when using multi-platform build
> systems such as OpenWrt.
> Prepend oxnas files with their platform prefix to comply with the naming
> scheme already used for most other platforms.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

There are few changes to oxnas in general, and Neil doesn't appear to be around
to ask at the moment.
I assume he doesn't mind me picking it up into next/dt directly.

Merged now, thanks,

        Arnd
