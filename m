From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Apr 2013 10:44:23 +0200
Subject: [PATCH 09/32] ARM: ux500: Remove unused 'data_width' attributes
 from SDI DMA configs
In-Reply-To: <1366279934-30761-10-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-10-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbf03ajQaYujGfimHE+hDVjNLycE3J9Q-W-tzN2EX0fkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 12:11 PM, Lee Jones <lee.jones@linaro.org> wrote:

> DMA configuration data is now allocated in the MMCI driver, so these
> are just ignored.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I tried just applying this (since it's pretty stand-alone) but seems to
be dependent on things not yet in Torvalds tree so lets keep it in this
series then...

Yours,
Linus Walleij
