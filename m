From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 7 Mar 2012 09:33:49 +0100
Subject: [PATCH v2 0/9] DMA engine cookie handling cleanups
In-Reply-To: <20120306223321.GD15201@n2100.arm.linux.org.uk>
References: <20120306223321.GD15201@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdYry6G4gi7LdVM4gYOQBKZCoQxdzLAGg1WcjB6rVD-PPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 6, 2012 at 11:33 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> This patch series cleans up the handling of cookies in DMA engine drivers.
> This is done by providing a set of inline library functions for common
> tasks:

I just applied the latest patches right off and tested with some stressy
MMC operations on the U300 and Ux500. (I had some minor hell
since patch 8/9 and 9/9 were uuencoded but managed to fix it...)

It works like a charm!

The patches look good too.

Tested-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
