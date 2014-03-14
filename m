From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 14 Mar 2014 11:55:28 +0100
Subject: [PATCH] pinctrl: tegra: add some missing Tegra114 entries
In-Reply-To: <1394731062-13097-1-git-send-email-swarren@wwwdotorg.org>
References: <1394731062-13097-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <CACRpkdZNq2Q9k5Bwed6jjgMF4E5v3UtF9MYK-EWOZhx0wKVO6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 13, 2014 at 6:17 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:

> From: Stephen Warren <swarren@nvidia.com>
>
> Add some missing pin and drive group definitions to the driver. These
> are all defined in the TRM, but missing from the driver for some reason.
>
> Fix a couple of mistakes in the drive group definitions.
>
> Much of the diff to tegra114_groups[] is an indentation change due to one
> of the new group names being long. git diff/show -w will highlight this.
>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Patch applied.

Yours,
Linus Walleij
