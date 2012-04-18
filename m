From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 18 Apr 2012 18:18:16 +0200
Subject: [PATCH 08/16] drivers/mmc: MMCI: Use correct GPIO binding for IRQ
 requests
In-Reply-To: <1334659448-11521-9-git-send-email-lee.jones@linaro.org>
References: <1334659448-11521-1-git-send-email-lee.jones@linaro.org>
 <1334659448-11521-9-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYody-C1p7USB-z14Nyu3o2jK4TDT2iDdKGzmSFad0wAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2012 at 12:44 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Now there are irqdomains in place for Snowball, we can request
> GPIO IRQs directly by their binding. This replaces the previous method
> of hard-coding the hwirq using u32 values in the DT.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Please just squash this into the previous MMCI patch and
resend it.

Yours,
Linus Walleij
