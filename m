From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sun, 12 Jun 2016 13:09:37 +0200
Subject: [GIT PULL] ARM: at91: soc for 4.8 #1
In-Reply-To: <20160612110703.GA24734@piout.net>
References: <20160612110703.GA24734@piout.net>
Message-ID: <20160612110937.GI19050@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The subject is obviously wrong and should be "ARM: at91: drivers for 4.8 #1"

On 12/06/2016 at 13:07:03 +0200, Alexandre Belloni wrote :
> Arnd, Olof, Kevin,
> 
> We finally get a driver for the EBI. It will hopefully allow to avoid
> relying on the bootloader for the EBI configuration.
> 
> The following changes since commit 1a695a905c18548062509178b98bc91e67510864:
> 
>   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.8-drivers
> 
> for you to fetch changes up to 1fdab21d1d52a85c31f932844242fec5fb81daac:
> 
>   memory: atmel-ebi: add DT bindings documentation (2016-06-02 08:32:25 +0200)
> 
> ----------------------------------------------------------------
> Drivers for 4.8:
>  - Add a driver for the EBI
> 
> ----------------------------------------------------------------
> Boris Brezillon (2):
>       memory: add Atmel EBI (External Bus Interface) driver
>       memory: atmel-ebi: add DT bindings documentation
> 
>  .../bindings/memory-controllers/atmel,ebi.txt      | 136 ++++
>  drivers/memory/Kconfig                             |  11 +
>  drivers/memory/Makefile                            |   1 +
>  drivers/memory/atmel-ebi.c                         | 771 +++++++++++++++++++++
>  4 files changed, 919 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/atmel,ebi.txt
>  create mode 100644 drivers/memory/atmel-ebi.c

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
