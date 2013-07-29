From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 29 Jul 2013 17:51:17 +0200
Subject: [PATCH] gpio/mxc: add chained_irq_enter/exit() to
 mx2_gpio_irq_handler
In-Reply-To: <1374152286-12955-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1374152286-12955-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <CACRpkdZjsAOtm2Jt7kY-VC2ToFfMQ+UxjWQE7aUZAbsBt0ugvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 2:58 PM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:

> Similar to commit
>
>         0e44b6e (gpio/mxc: add chained_irq_enter/exit() to mx3_gpio_irq_handler())
>
> . It doesn't seem to be critical to make the irqs work, but still it is
> more correct.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Patch is fine, but looks like this to me:

Content-Transfer-Encoding: base64

Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linus.walleij=linaro.org at lists.infradead.org

U2ltaWxhciB0byBjb21taXQKCgkwZTQ0YjZlIChncGlvL214YzogYWRkIGNoYWluZWRfaXJxX2Vu
dGVyL2V4aXQoKSB0byBteDNfZ3Bpb19pcnFfaGFuZGxlcigpKQoKLiBJdCBkb2Vzbid0IHNlZW0g
dG8gYmUgY3JpdGljYWwgdG8gbWFrZSB0aGUgaXJxcyB3b3JrLCBidXQgc3RpbGwgaXQgaXMKbW9y
ZSBjb3JyZWN0LgoKU2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtv
ZW5pZ0BwZW5ndXRyb25peC5kZT4KLS0tCkhlbGxvLAoKbm90ZSB0aGlzIGlzIGNvbXBsZXRlbHkg
dW50ZXN0ZWQuCgpVd2UKCiBkcml2ZXJzL2dwaW8vZ3Bpby1teGMuYyB8IDQgKysrKwogMSBmaWxl

The encoding is what screw things up.

Can you see if you can resend this without using base64?

Yours,
Linus Walleij
