From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 09 May 2015 17:58:43 +0200
Subject: [linux-sunxi] [PATCH 0/6] ARM: sunxi: Introduce Allwinner H3
 support
In-Reply-To: <1430904693-1404-1-git-send-email-jenskuske@gmail.com>
References: <1430904693-1404-1-git-send-email-jenskuske@gmail.com>
Message-ID: <554E2EB3.1000603@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 06-05-15 11:31, Jens Kuske wrote:
> Hi everyone,
>
> This patch series introduces basic kernel support for Allwinner's H3 SoC,
> mainly basic clocks and pinctrl. It also adds interrupts, timers,
> watchdog, RTC, dmaengine, MMC and UARTs, which are mostly compatible to
> those in earlier SoCs like A23 and A31, and can simply be reused.
>
> These patches are based on Maxime's sunxi/for-next branch from
> git://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git
>
> Patch 1 adds machine support for the H3.
>
> Patch 2 adds support for the basic clocks. The AHB1/AHB2 split could
> need some discussion.
>
> Patch 3 adds the pin sets for the H3 main PIO.
>
> Patch 4 adds the H3 specific parameters to the sun6i dmaengine driver.
>
> Patch 5 adds the DTSI for the H3.
>
> Patch 6 adds a DT for the Orange Pi Plus SBC, which these patches
> were developed and tested with.

Cool stuff, thanks for your work on this. Do you have any plans to also
add support for the H3 to upstream u-boot ?

Regards,

Hans
