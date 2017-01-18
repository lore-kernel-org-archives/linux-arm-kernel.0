From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 18 Jan 2017 09:53:57 +0100
Subject: [PATCH RFC 1/5] pinctrl: mvebu: constify mvebu_mpp_ctrl structures
In-Reply-To: <E1cRzdb-0002YP-8q@rmk-PC.armlinux.org.uk>
References: <20170113110240.GA29164@n2100.armlinux.org.uk>
 <E1cRzdb-0002YP-8q@rmk-PC.armlinux.org.uk>
Message-ID: <CACRpkdYuWsK=AVh8QEe8f9gJEmB++G39y8RJ4FWD+7QtSD1d2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2017 at 12:03 PM, Russell King
<rmk+kernel@armlinux.org.uk> wrote:

> As the mvebu_mpp_ctrl structures contain function pointers, it is
> preferable for these to be made read-only to prevent the function
> pointers being modified.  So make these const.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Patch applied.

Yours,
Linus Walleij
