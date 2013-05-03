From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 May 2013 16:01:56 +0200
Subject: [PATCH] ARM: ux500: Remove DMA address look-up table
In-Reply-To: <1367484683-3479-1-git-send-email-lee.jones@linaro.org>
References: <1367484683-3479-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdaeEDHNLFt2z=7L=iFbxbSkbe25mYxCG3+MreLsZZ21SA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 2, 2013 at 10:51 AM, Lee Jones <lee.jones@linaro.org> wrote:

> DMA addresses are now passed as part of the dmaengine API by invoking
> dmaengine_slave_config(). So there's no requirement for the DMA40
> driver to look them up in a table provided by platform data. This
> method does not fit in well using Device Tree either.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

This goes on top of some other changes right?

Right now the DMA series is confusing me a bit, there is
these 6 patches:
http://marc.info/?l=linux-arm-kernel&m=136698179306642&w=2

Then these 5 patches:
http://marc.info/?l=linux-arm-kernel&m=136740201416293&w=2

And then this single patch.

Where shall I start, i.e. which patches go first?

Can they all be combined into one big series?

Yours,
Linus Walleij
