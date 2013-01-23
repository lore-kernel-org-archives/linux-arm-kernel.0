From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 23 Jan 2013 11:04:24 +0100
Subject: [PATCH 8/8] ARM: ux500: Remove traces of the ios_handler from
 platform code
In-Reply-To: <1355404930-5691-9-git-send-email-lee.jones@linaro.org>
References: <1355404930-5691-1-git-send-email-lee.jones@linaro.org>
 <1355404930-5691-9-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbwQAEQxWpXHoEieou5rShcZvsGSddKLaOjwGeG-2o=wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 13, 2012 at 2:22 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Now MMCI on/off functionality is using the regulator framework
> from the MMCI driver, there is no need to keep the ios_handler
> laying around, duplicating functionality. So we're removing it.
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied to my ux500-cleanups branch.

Yours,
Linus Walleij
