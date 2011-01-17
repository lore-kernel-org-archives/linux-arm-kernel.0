From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 17 Jan 2011 09:40:14 -0800
Subject: [GIT PULL] pxa: patches for palm/voipac hw
In-Reply-To: <201101151943.45554.marek.vasut@gmail.com>
References: <201101151943.45554.marek.vasut@gmail.com>
Message-ID: <AANLkTik5A6NMc-wD1JahkKSSV-fWVj2nrFROALsEbJbH@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 15, 2011 at 10:43 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Hi Eric,
>
> can you pull the following into your -devel ?
>

Pulled.

> Thanks, Cheers!
>
> -----------------------
>
> The following changes since commit ea0c4f3ca8a55e7e3138c2c4b3e9f7fe34d3ecab:
>
> ?ARM: pxa: fix building issue of missing physmap.h (2011-01-15 04:29:21 -0600)
>
> are available in the git repository at:
> ?git://git.kernel.org/pub/scm/linux/kernel/git/marex/pxa-linux-2.6.git devel-fix
>
> Marek Vasut (9):
> ? ? ?ARM: pxa: PalmTE2: Use gpio arrays in backlight init
> ? ? ?ARM: pxa: Use gpio arrays in colibri_pcmcia driver
> ? ? ?ARM: pxa: Use gpio arrays in palmld_pcmcia driver
> ? ? ?ARM: pxa: Use gpio arrays in palmtc_pcmcia driver
> ? ? ?ARM: pxa: Use gpio arrays in palmtx_pcmcia driver
> ? ? ?ARM: pxa: Use gpio arrays in vpac270_pcmcia driver
> ? ? ?ARM: pxa: Use gpio arrays in palmld_hdd driver
> ? ? ?ARM: pxa: Update copyright notices for Palm devices
> ? ? ?ARM: pxa: PalmZ72: Add OV9640 camera support
>
> ?arch/arm/mach-pxa/include/mach/palmz72.h | ? ?5 +
> ?arch/arm/mach-pxa/palm27x.c ? ? ? ? ? ? ?| ? ?3 +-
> ?arch/arm/mach-pxa/palmte2.c ? ? ? ? ? ? ?| ? 31 ++------
> ?arch/arm/mach-pxa/palmz72.c ? ? ? ? ? ? ?| ?127 ++++++++++++++++++++++++++++
> ?drivers/ata/pata_palmld.c ? ? ? ? ? ? ? ?| ? 43 +++++-----
> ?drivers/pcmcia/pxa2xx_colibri.c ? ? ? ? ?| ?133 +++++++++++-------------------
> ?drivers/pcmcia/pxa2xx_palmld.c ? ? ? ? ? | ? 42 ++-------
> ?drivers/pcmcia/pxa2xx_palmtc.c ? ? ? ? ? | ? 75 +++--------------
> ?drivers/pcmcia/pxa2xx_palmtx.c ? ? ? ? ? | ? 57 +++----------
> ?drivers/pcmcia/pxa2xx_vpac270.c ? ? ? ? ?| ?110 +++++++------------------
> ?10 files changed, 276 insertions(+), 350 deletions(-)
>
