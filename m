From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 7 Aug 2013 15:48:16 +0200
Subject: [PATCH 13/13] ARM: ux500: Remove u9540.dts as it's been replaced
In-Reply-To: <1374243229-8585-14-git-send-email-lee.jones@linaro.org>
References: <1374243229-8585-1-git-send-email-lee.jones@linaro.org>
 <1374243229-8585-14-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdarR1_ytczATc3+6wvSeXg5gLd+W47vp3gqRC3O1i95GA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 19, 2013 at 4:13 PM, Lee Jones <lee.jones@linaro.org> wrote:

> This must have been a merge error. There was a patch which renamed the
> u9540.dts to ccu9540.dts, however the u9540.dts was reincarnate with
> the same patches which created it in the first place. Let's kill it
> once and for all.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

I applied all the rename patches but it appears they were never
really tested, so I made this patch fixing all the bugs they introduced.
(Quicker than iterating the patch set.)

Yours,
Linus Walleij
