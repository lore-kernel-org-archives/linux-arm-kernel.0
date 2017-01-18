From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 18 Jan 2017 09:57:20 +0100
Subject: [PATCH RFC 4/5] pinctrl: mvebu: switch drivers to generic simple
 mmio
In-Reply-To: <E1cRzdq-0002Yl-Lv@rmk-PC.armlinux.org.uk>
References: <20170113110240.GA29164@n2100.armlinux.org.uk>
 <E1cRzdq-0002Yl-Lv@rmk-PC.armlinux.org.uk>
Message-ID: <CACRpkdZCkZCV6F1XakGwB8Udz98r0svKW6eepZ5n79cP1SDubA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2017 at 12:03 PM, Russell King
<rmk+kernel@armlinux.org.uk> wrote:

> Move the mvebu pinctrl drivers over to the generic simple mmio
> implementation, saving a substantial number of lines of code in
> the process.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Very nice patch applied.

Yours,
Linus Walleij
