From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 May 2012 08:48:40 +0800
Subject: [RFC 06/34] dmaengine: PL08x: remove redundant spinlock
In-Reply-To: <E1SZIre-0006z6-GS@rmk-PC.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
 <E1SZIre-0006z6-GS@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdbQ1Lc6UmMipZm_xCen_0AR+7SUd6Qq==rpPpFw7CWFKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2012 at 5:37 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> The pl08x_driver_data spinlock is only ever initialized. ?Nothing else
> uses it. ?Let's get rid of it.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

This could also go into the -rc:s at this stage I believe.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
