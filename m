From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 29 Jul 2013 18:39:29 +0200
Subject: [PATCH 06/27] drivers/i2c/busses: don't check resource with
 devm_ioremap_resource
In-Reply-To: <1374602524-3398-7-git-send-email-wsa@the-dreams.de>
References: <1374602524-3398-1-git-send-email-wsa@the-dreams.de>
 <1374602524-3398-7-git-send-email-wsa@the-dreams.de>
Message-ID: <CACRpkdba0FHnWsCkNOEevmqvD9hZ_mroJ+mqbpjecG7sTAfBFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 23, 2013 at 8:01 PM, Wolfram Sang <wsa@the-dreams.de> wrote:

> devm_ioremap_resource does sanity checks on the given resource. No need to
> duplicate this in the driver.
>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
> Please apply via the subsystem-tree.

Are you talking to yourself ;-)

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
