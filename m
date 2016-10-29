From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 29 Oct 2016 10:23:29 +0200
Subject: [PATCH] video: ARM CLCD: fix Vexpress regression
In-Reply-To: <1476945992-5164-1-git-send-email-linus.walleij@linaro.org>
References: <1476945992-5164-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CACRpkdaKpG2yYtbwD4_vLOo1CwRKvh=RWvwmVeN56aQu1ur=HA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2016 at 8:46 AM, Linus Walleij <linus.walleij@linaro.org> wrote:

> The CLCD does not come up on Versatile Express as it does not
> (currently) have a syscon node for controlling the block apart
> from the CLCD itself. Make sure the .init() function can bail
> out without an error making it probe again.
>
> Reported-by: Amit Pundir <amit.pundir@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Tomi can you please pick this up?

Yours,
Linus Walleij
