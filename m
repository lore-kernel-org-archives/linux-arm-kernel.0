From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 18 Jan 2017 09:55:04 +0100
Subject: [PATCH RFC 2/5] pinctrl: mvebu: provide per-control private data
In-Reply-To: <E1cRzdg-0002YX-D7@rmk-PC.armlinux.org.uk>
References: <20170113110240.GA29164@n2100.armlinux.org.uk>
 <E1cRzdg-0002YX-D7@rmk-PC.armlinux.org.uk>
Message-ID: <CACRpkdZ-Fm8=kOsVLPf6YmYkrfzqT1ZedPvLQvHfdkMNN2402Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2017 at 12:03 PM, Russell King
<rmk+kernel@armlinux.org.uk> wrote:

> Provide per-control private data into each mvebu pinctrl method, which
> will allow us to provide some completely generic helpers without the
> global variable and per-instance function definitions that would be
> required when we have multiple pin controllers on a SoC.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Patch applied.

Yours,
Linus Walleij
