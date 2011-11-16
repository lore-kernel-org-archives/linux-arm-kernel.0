From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 16 Nov 2011 23:15:34 +0800
Subject: [GIT PULL] pxa: fixes for v3.2-rc1
In-Reply-To: <CAMPhdO_bAdTMAVZcgCwS568hPMzHZa7iwy5pUa-N2BOreaZFfw@mail.gmail.com>
References: <CAMPhdO_bAdTMAVZcgCwS568hPMzHZa7iwy5pUa-N2BOreaZFfw@mail.gmail.com>
Message-ID: <CAMPhdO-i2VXnJz8VY6w+oafng6x8v2g69XE9kdYrZGJNDhiyRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry Arnd, please hold on pull this. We have some concerns
to one of the patch. I'll update the GIT PULL a bit later.

On Wed, Nov 16, 2011 at 10:53 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> The following changes since commit 1ea6b8f48918282bdca0b32a34095504ee65bab5:
>
> ?Linux 3.2-rc1 (2011-11-07 16:16:02 -0800)
>
> are available in the git repository at:
> ?git://github.com/ycmiao/pxa-linux.git fix
>
> Daniel Mack (1):
> ? ? ?ARM: pxa: fix missing linux/gpio.h include
>
> Eric Miao (1):
> ? ? ?ARM: pxa168/gplugd: add the correct SSP device
>
> Haojian Zhuang (2):
> ? ? ?ARM: pxa: fix inconsistent CONFIG_USB_PXA27X
> ? ? ?ARM: mmp: fix build error on gpio
>
> ?arch/arm/configs/ezx_defconfig ? ? ? ? ? ?| ? ?2 +-
> ?arch/arm/configs/imote2_defconfig ? ? ? ? | ? ?2 +-
> ?arch/arm/configs/magician_defconfig ? ? ? | ? ?2 +-
> ?arch/arm/configs/zeus_defconfig ? ? ? ? ? | ? ?2 +-
> ?arch/arm/mach-mmp/gplugd.c ? ? ? ? ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-mmp/include/mach/gpio-pxa.h | ? ?2 +-
> ?arch/arm/mach-pxa/balloon3.c ? ? ? ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-pxa/colibri-pxa320.c ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-pxa/gumstix.c ? ? ? ? ? ? ? | ? ?2 +-
> ?arch/arm/mach-pxa/include/mach/palm27x.h ?| ? ?4 ++--
> ?arch/arm/mach-pxa/palm27x.c ? ? ? ? ? ? ? | ? ?4 ++--
> ?arch/arm/mach-pxa/palmtc.c ? ? ? ? ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-pxa/pxa3xx.c ? ? ? ? ? ? ? ?| ? ?1 +
> ?arch/arm/mach-pxa/vpac270.c ? ? ? ? ? ? ? | ? ?2 +-
> ?14 files changed, 16 insertions(+), 15 deletions(-)
>
