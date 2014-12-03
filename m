From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 3 Dec 2014 14:52:48 +0100
Subject: [PATCH 14/16] ARM: ux500: switch from gic_arch_extn to
 gic_set_irqchip_flags
In-Reply-To: <1417539497-20101-15-git-send-email-marc.zyngier@arm.com>
References: <1417539497-20101-1-git-send-email-marc.zyngier@arm.com>
 <1417539497-20101-15-git-send-email-marc.zyngier@arm.com>
Message-ID: <CACRpkdbBm=zDn4ukk-xCeOQ_jjbyJdn7kvf7yoqHtxUz4ANUJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 2, 2014 at 5:58 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:

> Instead of directly touching gic_arch_extn, which is about to
> be removed, use gic_set_irqchip_flags instead.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
