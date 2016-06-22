From: scott.branden@broadcom.com (Scott Branden)
Date: Wed, 22 Jun 2016 10:06:26 -0700
Subject: [PATCH v4 0/3] pwm support for Broadcom iProc SoC's
In-Reply-To: <1466594987-26537-1-git-send-email-yendapally.reddy@broadcom.com>
References: <1466594987-26537-1-git-send-email-yendapally.reddy@broadcom.com>
Message-ID: <576AC592.7030805@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dhanajaya,

Patch series looks good.

Acked-by: Scott Branden <scott.branden@broadcom.com>

On 16-06-22 04:29 AM, Yendapally Reddy Dhananjaya Reddy wrote:
> This patchset contains the pwm support for the Broadcom's iProc SoC's.
>
> The first patch provides the documentation details and the
> second patch contains the controller support details. The third patch
> contains the enable method for Northstar Plus SoC.
>
> This patch series has been tested on NSP bcm958625HR board.
> The pwm is not enabled for this board as the pins are open and not used.
>
> This patch series is based on v4.7.0-rc1 and is available from github
> repo: https://github.com/Broadcom/cygnus-linux.git
> branch: iproc-pwm-v4
>
>
> Changes since v3
> Addressed comments from Scott to include COMPILE_TEST
>
> Changes since v2
> Rebased on v4.7.0-rc1
>
> Changes since v1
> Addressed the review comments from Thierry
>   1. Use separate driver for iProc SoC's.
>   2. Added Robs ack to the Documentation patch
>
> Yendapally Reddy Dhananjaya Reddy (3):
>    Documentation: dt: Add Broadcom iproc pwm controller binding
>    pwm: iproc: Add support for Broadcom iproc pwm controller
>    ARM: dts: NSP: Add PWM Support to DT
>
>   .../devicetree/bindings/pwm/brcm,iproc-pwm.txt     |  21 ++
>   arch/arm/boot/dts/bcm-nsp.dtsi                     |   8 +
>   drivers/pwm/Kconfig                                |  10 +
>   drivers/pwm/Makefile                               |   1 +
>   drivers/pwm/pwm-bcm-iproc.c                        | 327 +++++++++++++++++++++
>   5 files changed, 367 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/pwm/brcm,iproc-pwm.txt
>   create mode 100644 drivers/pwm/pwm-bcm-iproc.c
>

Regards,
Scott
