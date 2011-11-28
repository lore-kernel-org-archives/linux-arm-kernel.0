From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 28 Nov 2011 17:57:29 +0800
Subject: [V1 1/3] RTC: sa1100: Clean out ost register
In-Reply-To: <1322219170-1774-1-git-send-email-jtzhou@marvell.com>
References: <1322219170-1774-1-git-send-email-jtzhou@marvell.com>
Message-ID: <CAN1soZy+Es_wf7-wzTbmE7OKwpRXjaWDW7foYCNbmqLE9x7Qxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 25, 2011 at 7:06 PM, Jett.Zhou <jtzhou@marvell.com> wrote:
> These registers are used in old ioctl of UIE and PIE, now they are
> emulated by rtc generic code of hrtimer, so it can be removed.
>
> Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
> ---
> ?drivers/rtc/rtc-sa1100.c | ? ?3 ---
> ?1 files changed, 0 insertions(+), 3 deletions(-)
>
Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
