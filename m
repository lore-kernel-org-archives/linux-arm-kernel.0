From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 3 Apr 2012 22:51:02 +0200
Subject: [PATCH 11/11] ARM: dt: tegra20: add pinmux to device tree
In-Reply-To: <1333148404-17691-12-git-send-email-swarren@wwwdotorg.org>
References: <1333148404-17691-1-git-send-email-swarren@wwwdotorg.org>
 <1333148404-17691-12-git-send-email-swarren@wwwdotorg.org>
Message-ID: <CACRpkda116wMmvkRqtZVD+2MshCe_fNJAA001CbWQ3ByEbK8wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 31, 2012 at 1:00 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:

> From: Stephen Warren <swarren@nvidia.com>
>
> This adds a complete pinmux configuration to all Tegra20 device tree
> files. This allows removal of board-dt-tegra20.c's use of the pinmux
> board files, and the special device tree handling in board-pinmux.c.
>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Pretty cool huh? :-)
We've come a long way the recent months.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
