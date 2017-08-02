From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 2 Aug 2017 14:32:38 +0200
Subject: [PATCH 3/4] rtc: pl031: avoid exposing alarm if no interrupt
In-Reply-To: <E1dYKiK-0001kZ-6E@rmk-PC.armlinux.org.uk>
References: <20170720231745.GE31807@n2100.armlinux.org.uk>
 <E1dYKiK-0001kZ-6E@rmk-PC.armlinux.org.uk>
Message-ID: <CACRpkdadsnmL2e5XPoE9LFs4azqemZ69FbY_-bzjJigJMCf-qw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 21, 2017 at 1:18 AM, Russell King
<rmk+kernel@armlinux.org.uk> wrote:

> If the RTC has no interrupt, there is little point in exposing the RTC
> alarm capabilities, as it can't be used as a wakeup source nor can it
> deliver an event to userspace.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

This makes all kind of sense.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
