From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 21 Oct 2015 21:23:52 +0200
Subject: [PATCH 0/6] ARM: sunxi: Introduce Allwinner H3 support
In-Reply-To: <1445444007-4260-1-git-send-email-jenskuske@gmail.com>
References: <1445444007-4260-1-git-send-email-jenskuske@gmail.com>
Message-ID: <5627E648.3090408@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 21-10-15 18:13, Jens Kuske wrote:
> Hi everyone,
>
> This is v3 of my patch series introducing basic kernel support for Allwinner's
> H3 SoC. It mainly adds basic clocks and pinctrl. It also adds interrupts,
> timers, watchdog, RTC, dmaengine, MMC and UARTs, which are mostly compatible
> to those in earlier SoCs like A23 and A31, and can simply be reused.
>
> These patches are based on Maxime's sunxi/for-next branch from
> git://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git

p.s.

For the next version you will want to base these on the sunxi-next branch of:

https://github.com/linux-sunxi/linux-sunxi.git

There is at least a conflict with the pio driver due to the addition of
the a83 pio driver which mripard/linux/sunxi/for-next does not have, where
as linux-sunxi/sunxi-next does have that merged in.

Regards,

Hans
