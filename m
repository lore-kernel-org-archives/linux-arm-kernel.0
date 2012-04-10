From: govindraj.raja@ti.com (Raja, Govindraj)
Date: Tue, 10 Apr 2012 15:36:49 +0530
Subject: [GIT PULL]: omap-serial updates for 3.4-rc
In-Reply-To: <1334052148-10385-1-git-send-email-govindraj.raja@ti.com>
References: <1334052148-10385-1-git-send-email-govindraj.raja@ti.com>
Message-ID: <CAMrsUdKDhuDLr2=0uiQtY=r4pvmJQo=pJgERRCXySLghO7yGXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CC'ing Linux-ARM


On Tue, Apr 10, 2012 at 3:32 PM, Govindraj.R <govindraj.raja@ti.com> wrote:
> Hi Tony,
>
> Please Pull the following omap uart changes.
> Changes basically involves getting rid of cpu checks
> for populating erratas and features and move the same
> from serial.c to omap-serial.c, MVR reg is used to find
> uart versions and errata flags are populated accordingly.
>
> --
> Thanks,
> Govindraj.R
>
> The following changes since commit 0034102808e0dbbf3a2394b82b1bb40b5778de9e:
>
> ?Linux 3.4-rc2 (2012-04-07 18:30:41 -0700)
>
> are available in the git repository at:
>
> ?git://gitorious.org/linux-3-x/omap-serial.git for_3.4/uart_fixes
>
> for you to fetch changes up to 6c34f211069409ea6d08b900eeaf86ef8efd0dca:
>
> ?OMAP2+: UART: replace omap34xx/omap4xx cpu checks with not omap24xx (2012-04-10 15:14:58 +0530)
>
> ----------------------------------------------------------------
> Govindraj.R (3):
> ? ? ?OMAP2+: UART: Remove cpu checks for populating errata flags
> ? ? ?OMAP2+: UART: enable tx wakeup bit for wer reg
> ? ? ?OMAP2+: UART: replace omap34xx/omap4xx cpu checks with not omap24xx
>
> ?arch/arm/mach-omap2/serial.c ? ? ? ? ? ? ? ? ?| ? 13 +---
> ?arch/arm/plat-omap/include/plat/omap-serial.h | ? ?9 +++-
> ?drivers/tty/serial/omap-serial.c ? ? ? ? ? ? ?| ? 83 ++++++++++++++++++++++++-
> ?3 files changed, 91 insertions(+), 14 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
