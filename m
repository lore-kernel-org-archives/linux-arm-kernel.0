From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 1 Jun 2012 09:37:45 +0800
Subject: [PATCH 2/3] pinctrl: add exynos4210 specific driver data for
 samsung pinctrl driver
In-Reply-To: <1337816857-14694-3-git-send-email-thomas.abraham@linaro.org>
References: <1337816857-14694-1-git-send-email-thomas.abraham@linaro.org>
 <1337816857-14694-3-git-send-email-thomas.abraham@linaro.org>
Message-ID: <CACRpkdYA1on77kDb3qvJGr9E332EiNt_piY40iLHY3rs4f57=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 24, 2012 at 7:47 AM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:

> Add information about the Exynos4210 pin banks, SoC specific configuration
> callbacks and driver data which is used by the Samsung pinctrl driver.
>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Overall this patch set is looking really good, just the final touches
on the main
driver needed from my point of view, would be nice to have some DT review
though.

Yours,
Linus Walleij
