From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 12 Mar 2014 15:22:53 +0100
Subject: [PATCH 2/4] pinctrl: tegra: init Tegra20/30 at module_init time
In-Reply-To: <1394220137-16351-2-git-send-email-swarren@wwwdotorg.org>
References: <1394220137-16351-1-git-send-email-swarren@wwwdotorg.org>
 <1394220137-16351-2-git-send-email-swarren@wwwdotorg.org>
Message-ID: <CACRpkdbukJpMcK6JhqXqJxGp3aVMEMZYOYQ7APrPJ40+xMTz9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 7, 2014 at 8:22 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:

> From: Stephen Warren <swarren@nvidia.com>
>
> The Tegra20/30 pinctrl drivers currently initializes at arch_initcall,
> whereas Tegra114/124 pinctrl drivers initialize at module_init time.
> Convert Tegra20/30 to work the same way as the other drivers.
>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Patch applied.

Yours,
Linus Walleij
