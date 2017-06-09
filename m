From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 9 Jun 2017 10:59:35 +0200
Subject: [PATCH] pinctrl: sunxi: constify irq_domain_ops
In-Reply-To: <20170602112958.3882-1-tklauser@distanz.ch>
References: <20170602112958.3882-1-tklauser@distanz.ch>
Message-ID: <CACRpkda37Xzfh_w08PeEGUDJn+5GkBNGQmsMaX98QZRpnkSEjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 2, 2017 at 1:29 PM, Tobias Klauser <tklauser@distanz.ch> wrote:

> struct irq_domain_ops is not modified, so it can be made const.
>
> Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Patch applied with Maxime's ACK.

Yours,
Linus Walleij
