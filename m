From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 20 Nov 2012 20:25:25 +0100
Subject: [PATCH v2] clk: move IM-PD1 clocks to drivers/clk
In-Reply-To: <20121120190024.GV3290@n2100.arm.linux.org.uk>
References: <1353437696-23285-1-git-send-email-linus.walleij@linaro.org>
 <20121120190024.GV3290@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdbaDqcs-YbFDsx6SofUy+m7FsoxckoY+Rx4maQH9L+jVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 8:00 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> Where's the cleanup paths?
>
> You do realise it's possible to unbind and rebind the whole impd1 board
> via sysfs, which means if you don't do the cleanup you'll end up
> re-registering the same clocks again.
>
> Until that's fixed, NAK.

OK sorry, fixing...

Yours,
Linus Walleij
