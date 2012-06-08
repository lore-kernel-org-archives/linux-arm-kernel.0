From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 8 Jun 2012 10:32:02 +0200
Subject: [CFT] PL08x patches
In-Reply-To: <20120607104527.GA15973@n2100.arm.linux.org.uk>
References: <20120607103434.GQ8262@n2100.arm.linux.org.uk>
 <E1Sca9b-0003ax-4E@rmk-PC.arm.linux.org.uk>
 <20120607104527.GA15973@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdadwL6AvEtHK0RyBKXCvMhc_g8n5im0RjJCHof4-Bs_-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 7, 2012 at 12:45 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> Here's the PL08x patches.

I've tested the entire set: first the three patches splitting out the virtual
channels, then the remaining 31 patches on PL08x.

The test was performed on a Nomadik S8815 which has a pretty
much vanilla PL08x block.

The DMAengine memcpy test completes just fine and behave like
before.
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
