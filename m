From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 24 Jan 2013 17:06:06 +0100
Subject: [PATCH 1/1] ARM: ux500: Fix u9540 booting issues
In-Reply-To: <1354008890-10476-1-git-send-email-lee.jones@linaro.org>
References: <1354008890-10476-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdaFwjobNqOLQkk1iOYQotWZ20_LccoghxMETBMmt0f1ew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2012 at 10:34 AM, Lee Jones <lee.jones@linaro.org> wrote:

> The u9540 stopped booting after the v3.7 merge window due to
> a lack of common clk support and early PRCMU initialisation.
> In this patch we rectify these issues, placing the u9540
> development board back into a successfully booting state.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied to my ux500-fixes branch, will go into ARM SoC
pull request RealSoonNow.

Yours,
Linus Walleij
