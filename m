From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 16 Jan 2012 10:46:00 +0100
Subject: [PATCH v3] pinctrl: add support for group and pinmux states
In-Reply-To: <7FE21149F4667147B645348EC60578850910C3@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1326673015-963-1-git-send-email-linus.walleij@stericsson.com>
 <7FE21149F4667147B645348EC60578850910C3@039-SN2MPN1-013.039d.mgd.msft.net>
Message-ID: <CACRpkdaLEasbm-_Vg9VzD+EwwJst1yLQ1sruPaHtFASxcRXXUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2012 at 9:26 AM, Dong Aisheng-B29396
<B29396@freescale.com> wrote:

> The question is that we allow customer to define pingroup state and this is
> independent on pinctrl core.

You are right, this patch might not be helpful :-(

I had bad dreams after writing it, and I think I also missed Stephens point,
that the pinctrl core should iteratively call the config interface of the
controller while walking a config.

I am authoring a different proposal which is much closer to the pinmux
maps, and thus closer to what you're currently doing with the device
tree bindings and all.

Hold on, hope to post this later today.

Linus Walleij
