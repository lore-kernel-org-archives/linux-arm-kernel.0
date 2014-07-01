From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 1 Jul 2014 15:53:19 +0300
Subject: [PATCHv5 07/15] hwspinlock/omap: enable build for AM33xx, AM43xx
 & DRA7xx
In-Reply-To: <1398904476-26200-8-git-send-email-s-anna@ti.com>
References: <1398904476-26200-1-git-send-email-s-anna@ti.com>
 <1398904476-26200-8-git-send-email-s-anna@ti.com>
Message-ID: <CAK=WgbaVzfWLXiX0y9K=-FAG98ywbWojtyyoEket-q5e5pdufA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suman,

On Thu, May 1, 2014 at 3:34 AM, Suman Anna <s-anna@ti.com> wrote:
> HwSpinlocks are supported on AM33xx, AM43xx and DRA7xx SoC
> device families as well. The IPs are identical to that of
> OMAP4/OMAP5, except for the number of locks.
>
> Add a depends on to the above family of SoCs to enable the
> build support for OMAP hwspinlock driver for any of the above
> SoC configs.
>
> Signed-off-by: Suman Anna <s-anna@ti.com>

This looks too like an independent change. If you want it merged
without waiting for the entire series please submit it separately.

Thanks,
Ohad.
