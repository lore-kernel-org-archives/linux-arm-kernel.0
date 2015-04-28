From: lee@kernel.org (Lee Jones)
Date: Tue, 28 Apr 2015 10:27:46 +0100
Subject: [PATCH 2/3] ARM: bcm2835: Add the Raspberry Pi firmware driver
In-Reply-To: <1430176449-12322-3-git-send-email-eric@anholt.net>
References: <1430176449-12322-1-git-send-email-eric@anholt.net>
 <1430176449-12322-3-git-send-email-eric@anholt.net>
Message-ID: <20150428092746.GH11956@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 27 Apr 2015, Eric Anholt wrote:

> This gives us a function for making mailbox property channel requests
> of the firmware, and uses it to control the 3 power domains provided
> by the firmware.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  arch/arm/mach-bcm/Kconfig                          |   2 +
>  arch/arm/mach-bcm/Makefile                         |   1 +
>  arch/arm/mach-bcm/raspberrypi-firmware.c           | 285 +++++++++++++++++++++

drivers/firmware ?

>  .../dt-bindings/arm/raspberrypi-firmware-power.h   |  16 ++
>  include/soc/bcm2835/raspberrypi-mailbox-property.h | 110 ++++++++
>  5 files changed, 414 insertions(+)
>  create mode 100644 arch/arm/mach-bcm/raspberrypi-firmware.c
>  create mode 100644 include/dt-bindings/arm/raspberrypi-firmware-power.h
>  create mode 100644 include/soc/bcm2835/raspberrypi-mailbox-property.h
