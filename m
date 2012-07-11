From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 11 Jul 2012 18:43:38 +0200
Subject: [PATCH 3/9] ARM: versatile: Make plat-versatile clock optional
In-Reply-To: <1342013791-19516-4-git-send-email-pawel.moll@arm.com>
References: <1342013791-19516-1-git-send-email-pawel.moll@arm.com>
 <1342013791-19516-4-git-send-email-pawel.moll@arm.com>
Message-ID: <CACRpkdYiW8C298K3uPzfJrq09vs-r90brMT_imgz54KtP4Xqsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2012 at 3:36 PM, Pawel Moll <pawel.moll@arm.com> wrote:

> ... in preparation for common clock coming for Integrator
> and Versatile Express.
>
> Based on Linus Walleij's "ARM: integrator: convert to common
> clock" patch.
>
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>

I think Mike is already queueing my patch, so if you're changing
anything you should build on top of that and submit it to the
clk tree.

Mike, is the Integrator patches making it into your for-next branch?

The merge window is closing in you know...

Yours,
Linus Walleij
