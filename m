From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Aug 2012 13:13:49 +0200
Subject: [PATCH 13/22] ARM: ux500: Fork MSP platform registration for
 step-by-step DT enablement
In-Reply-To: <1344527268-5964-14-git-send-email-lee.jones@linaro.org>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-14-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdaem6t3mvy-_9e=GEgwWoeBQSoX3Hf1L=hjWsvLJdsVAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 9, 2012 at 5:47 PM, Lee Jones <lee.jones@linaro.org> wrote:

> We've done this before and it worked well last time. Here we're
> duplicating a complex registration function to ease the process
> of enabling it for Device Tree. As there are quite a few steps
> taken during the registration process, it makes sense to break
> them up into more manageable chunks. This patch will aid us.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

I understand you have used this approach before so:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
