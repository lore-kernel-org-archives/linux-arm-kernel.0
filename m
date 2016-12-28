From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 28 Dec 2016 13:47:32 -0200
Subject: [PATCH] irqchip: mxs: Enable SKIP_SET_WAKE and MASK_ON_SUSPEND
In-Reply-To: <1482863397-11400-1-git-send-email-stefan.wahren@i2se.com>
References: <1482863397-11400-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <CAOMZO5C-TyDk5=kCuraOb_L8icCPrvBKryhhn-s-C76EGta8=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 27, 2016 at 4:29 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> The ICOLL controller doesn't provide any facility to configure the
> wakeup sources. That's the reason why this implementation lacks
> the irq_set_wake implementation. But this prevent us from properly
> entering power management states like "suspend to idle".
>
> So enable the flags IRQCHIP_SKIP_SET_WAKE and
> IRQCHIP_MASK_ON_SUSPEND to let the irqchip core allows and handles
> the power management.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
