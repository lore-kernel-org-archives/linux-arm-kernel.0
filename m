From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 12 Mar 2014 15:28:38 +0100
Subject: [PATCH 4/4] pinctrl: tegra: consistency cleanup
In-Reply-To: <1394220137-16351-4-git-send-email-swarren@wwwdotorg.org>
References: <1394220137-16351-1-git-send-email-swarren@wwwdotorg.org>
 <1394220137-16351-4-git-send-email-swarren@wwwdotorg.org>
Message-ID: <CACRpkdbiP-jcuwVu4PeEDwhwjsOKTkOxQ2cQ5ZCv8GBH4OFFUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 7, 2014 at 8:22 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:

> From: Stephen Warren <swarren@nvidia.com>
>
> Fix Tegra30/114/124 pinmux drivers consistency issues.
> * Sort all lists of the same object type (e.g. #defines for pins, and
>   the array that defines their names) in the same order.
> * Whitespace fixes.
> * Consistency in layout between the 3 drivers.
>
> These driver files were also auto-generated, which should allow us to
> make e.g. the U-Boot drivers completely consistent with the kernel in
> the future:-)
>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Umm yeah I trust you on this, patch applied.

Yours,
Linus Walleij
