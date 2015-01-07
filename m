From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 7 Jan 2015 10:45:10 +0100
Subject: [RESEND PATCH 2/2] pinctrl: st: Add irq_disable hook to
 st_gpio_irqchip
In-Reply-To: <1420452254-30625-3-git-send-email-patrice.chotard@st.com>
References: <1420452254-30625-1-git-send-email-patrice.chotard@st.com>
 <1420452254-30625-3-git-send-email-patrice.chotard@st.com>
Message-ID: <CACRpkdb9cHaKe3a5rr2w9WVUOp7um9P41j8c4MYZTf0APHXsKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 5, 2015 at 11:04 AM, Patrice CHOTARD <patrice.chotard@st.com> wrote:

> Currently disable_irq() doesn't work for pinctrl-st driver, due to
> missing irq_disable hook in the driver.
> disable_irq() is required only for level-triggered interrupts, which
> is not the case normally.
>
> Signed-off-by: Pankaj Dev <pankaj.dev@st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>

Patch applied to fixes. Sorry for the delay.

Yours,
Linus Walleij
