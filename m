From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 7 Oct 2017 12:52:47 +0200
Subject: [PATCH 1/7] gpio: brcmstb: allow all instances to be wakeup
 sources
In-Reply-To: <20170930034057.15166-2-opendmb@gmail.com>
References: <20170930034057.15166-1-opendmb@gmail.com>
 <20170930034057.15166-2-opendmb@gmail.com>
Message-ID: <CACRpkdaLBXeSJBMgXM2e5JhZWnLL4rq0Qt97AeRfTZ7V-_NLDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 30, 2017 at 5:40 AM, Doug Berger <opendmb@gmail.com> wrote:

> This commit allows a wakeup parent interrupt to be shared between
> instances.
>
> It also removes the redundant can_wake member of the private data
> structure by using whether the parent_wake_irq has been defined to
> indicate that the GPIO device can wake.
>
> Fixes: 19a7b6940b78 ("gpio: brcmstb: Add interrupt and wakeup source support")
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Patch applied with Gregory's and Florian's ACKs.

Yours,
Linus Walleij
