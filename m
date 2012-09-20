From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 20 Sep 2012 08:45:50 +0200
Subject: [PATCH 4/5] gpio: Make gpio-msm-v1 into a platform driver
In-Reply-To: <1348038044-1790-5-git-send-email-sboyd@codeaurora.org>
References: <1348038044-1790-1-git-send-email-sboyd@codeaurora.org>
 <1348038044-1790-5-git-send-email-sboyd@codeaurora.org>
Message-ID: <CACRpkdZZ4y2TpkDAgxp38hLbsvxV3hqQ0PRjEQ1s+CXuq8TVQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 19, 2012 at 9:00 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:

> Doing this removes the dependence of this driver on the
> msm_iomap.h and cpu.h mach include headers provied by MSM. This
> is necessary to support single zImage work in the future and
> allows us to remove cpu.h entirely and brings us closer to
> removing msm_iomap.h.
>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Rohit Vaswani <rvaswani@codeaurora.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

This must be encouraged:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Stephen, do you have a mainline-based kernel tree that can boot
on my DragonBoard? It's just sitting idle here... I pushed David
in the past, just naggin'...

Yours,
Linus Walleij
