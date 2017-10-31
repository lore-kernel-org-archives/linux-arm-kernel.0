From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 31 Oct 2017 10:28:24 +0100
Subject: [PATCH v2 2/7] gpio: brcmstb: allow all instances to be wakeup
 sources
In-Reply-To: <20171024195451.30535-3-opendmb@gmail.com>
References: <20171024195451.30535-1-opendmb@gmail.com>
 <20171024195451.30535-3-opendmb@gmail.com>
Message-ID: <CACRpkdbdZgP77qXvEJAZB7apZSEpb8a9WrxAuspW+yBXyEavWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 24, 2017 at 9:54 PM, Doug Berger <opendmb@gmail.com> wrote:

> This commit allows a wakeup parent interrupt to be shared between
> instances.
>
> It also removes the redundant can_wake member of the private data
> structure by using whether the parent_wake_irq has been defined to
> indicate that the GPIO device can wake.
>
> Fixes: 19a7b6940b78 ("gpio: brcmstb: Add interrupt and wakeup source support")
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Acked-by: Gregory Fong <gregory.0xf0@gmail.com>

Patch applied.

Yours,
Linus Walleij
