From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 28 Nov 2011 17:58:14 +0800
Subject: [V1 2/3] RTC: sa1100: remove redundant code of setting alarm
In-Reply-To: <1322219199-1825-1-git-send-email-jtzhou@marvell.com>
References: <1322219199-1825-1-git-send-email-jtzhou@marvell.com>
Message-ID: <CAN1soZx8x9gkVzwS+rW6XivfnZtLqOrTDuW04wYdMwMaFfYC+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 25, 2011 at 7:06 PM, Jett.Zhou <jtzhou@marvell.com> wrote:
> In rtc generic interface of setting alarm, it will check the alarm time
> value valid or not, so rtc_periodic_alarm is redundant, remove it.
>
> Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
> ---
> ?drivers/rtc/rtc-sa1100.c | ? 53 ++++++++++-----------------------------------
> ?1 files changed, 12 insertions(+), 41 deletions(-)
>
Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
