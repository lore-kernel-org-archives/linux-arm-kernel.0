From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sun, 4 Mar 2012 09:05:47 +0800
Subject: Status of gpio-pxa driver and dummy clock
In-Reply-To: <87eht9tllp.fsf@free.fr>
References: <87eht9tllp.fsf@free.fr>
Message-ID: <CAN1soZwtVm=qBw97AeeysfTXhCQg7XonKkHAE_dn6EYbLHnKBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 4, 2012 at 5:34 AM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Hi Haojian,
>
> As you certainly know, Russell reverted the patch "ARM: pxa: add dummy clock for
> sa1100-rtc", id a55b5adaf403c4d032e0871ad4ee3367782f4db6. As a consequence, the
> dummy clock for gpio-pxa was removed, causing breakage of gpio-pxa driver.
>
> I wonder if you (or somebody through you) sent an update to fix the gpio-pxa by
> either fixing gpio-pxa or adding back "pxa-gpio" clock. As of today, I see no
> fix in 3.3-rc free (Linus tree).
>

This patch is already merged into arm-soc tree for v3.4. I don't have
a plan to push it into
v3.3.

Thanks
Haojian
