From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 15 Apr 2016 13:47:26 +0200
Subject: [PATCH 1/7 RESEND] video: ARM CLCD: runtime check for Versatile
In-Reply-To: <1456221704-5792-2-git-send-email-linus.walleij@linaro.org>
References: <1456221704-5792-1-git-send-email-linus.walleij@linaro.org>
 <1456221704-5792-2-git-send-email-linus.walleij@linaro.org>
Message-ID: <CACRpkdYAcVy+PA5nXnWjWoLhh0UQm1=WMAzXiJtgcK0TsEa=zA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 23, 2016 at 11:01 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:

> The current compile-time check for inversed IENB/CNTL does not
> work in multiplatform boots: as soon as versatile is included
> in the build, the IENB/CNTL is switched and breaks graphics.
> Convert this to a runtime switch.
>
> Cc: stable at vger.kernel.org
> Cc: Rob Herring <robh@kernel.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Fixes: a29da136de34 ("ARM: versatile: convert to multi-platform")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Tomi can you PLEASE merge this patch which is regressing all
the Versatile hardware since commit a29da136de34?

It is not dependent on the rest of the series.

I am coming back to revising the rest of the patches, but
this one need to go in.

Yours,
Linus Walleij
