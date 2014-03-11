From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 11 Mar 2014 11:16:53 +0100
Subject: [PATCH] pinctrl: tegra: fix some typos and inconsistencies
In-Reply-To: <1394056412-12879-1-git-send-email-swarren@wwwdotorg.org>
References: <1394056412-12879-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <CACRpkdY9VqKBHs+mOr5MD3fE5tzBghCU82dHfoSG_kNZvW8jVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 5, 2014 at 10:53 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:

> From: Stephen Warren <swarren@nvidia.com>
>
> drive_dev3_pins in pinctrl-tegra114.c wasn't used; delete it.
>
> pinctrl-tegra124.c had quite a few typos. Fix those.
>
> pinctrl-tegra124.c had a few mismatches between the *_groups[] ararys
> and the function lists in tegra124_groups[]. Fix those.
>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Patch applied.

Yours,
Linus Walleij
