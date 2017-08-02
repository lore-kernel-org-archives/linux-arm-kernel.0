From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 2 Aug 2017 14:30:57 +0200
Subject: [PATCH 1/4] rtc: pl031: constify amba_ids
In-Reply-To: <E1dYKi9-0001kK-RQ@rmk-PC.armlinux.org.uk>
References: <20170720231745.GE31807@n2100.armlinux.org.uk>
 <E1dYKi9-0001kK-RQ@rmk-PC.armlinux.org.uk>
Message-ID: <CACRpkda1kSAFJZHqGAPWiFckGJ5AoJG4htB0+r56gDFKmxubrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 21, 2017 at 1:18 AM, Russell King
<rmk+kernel@armlinux.org.uk> wrote:

> The AMBA device IDs should be marked const.  Make that so.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
