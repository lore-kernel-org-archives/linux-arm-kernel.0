From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 28 Mar 2014 20:01:33 +0100
Subject: [PATCH 49/75] ARM: l2c: fix register naming
In-Reply-To: <E1WTYYH-0007GB-3M@rmk-PC.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYYH-0007GB-3M@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdY99t-zd2C5yz9gjbucze99pZj6zOfKyL9jwDgk-FfoUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 28, 2014 at 4:18 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> We have a mixture of different devices with different register layouts,
> but we group all the bits together in an opaque mess.  Split them out
> into those which are L2C-310 specific and ones which refer to earlier
> devices.  Provide full auxiliary control register definitions.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Linus Walleij <linus.walleij@linaro.org>
For ux500.

Yours,
Linus Walleij
