From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 1 Dec 2012 16:56:41 +0100
Subject: [PATCH 1/1] mfd: Simplify IRQ domain registration code in STMPE
In-Reply-To: <1353675386-6749-1-git-send-email-lee.jones@linaro.org>
References: <1353675386-6749-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbkGD3edGFf=3begHOtoYg+kZFHgQriZ4LT1OEz1FpD=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2012 at 1:56 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Historically, a driver would have to decide whether it required
> a Linear or Legacy IRQ domain when registering one. This can end
> up as quite a lot of code. A new Simple call now exists which
> simplifies this process. Let's make use of it here.
>
> Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Should do the trick!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
