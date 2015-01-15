From: arno@natisbad.org (Arnaud Ebalard)
Date: Thu, 15 Jan 2015 22:48:37 +0100
Subject: [PATCH v4 2/5] drivers/rtc/rtc-armada38x: Add a new RTC driver
 for recent mvebu SoCs
In-Reply-To: <1421342601-20384-3-git-send-email-gregory.clement@free-electrons.com>
 (Gregory CLEMENT's message of "Thu, 15 Jan 2015 18:23:18 +0100")
References: <1421342601-20384-1-git-send-email-gregory.clement@free-electrons.com>
 <1421342601-20384-3-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <87egqv7m16.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

Gregory CLEMENT <gregory.clement@free-electrons.com> writes:

> The new mvebu SoCs come with a new RTC driver. This patch adds the
> support for this new IP which is currently found in the Armada 38x
> SoCs.
>
> This RTC provides two alarms, but only the first one is used in the
> driver. The RTC also allows using periodic interrupts.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  drivers/rtc/Kconfig         |  10 ++
>  drivers/rtc/Makefile        |   1 +
>  drivers/rtc/rtc-armada38x.c | 320 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 331 insertions(+)
>  create mode 100644 drivers/rtc/rtc-armada38x.c

FWIW:

Reviewed-by: Arnaud Ebalard <arno@natisbad.org>

Cheers,

a+
