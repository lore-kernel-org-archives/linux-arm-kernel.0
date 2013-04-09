From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 9 Apr 2013 10:14:30 +0200
Subject: [PATCH 1/3] pinctrl: exynos5440: fix probe failure due to missing
 pin-list in config nodes
In-Reply-To: <1364310754-3692-2-git-send-email-kgene.kim@samsung.com>
References: <1364310754-3692-1-git-send-email-kgene.kim@samsung.com>
 <1364310754-3692-2-git-send-email-kgene.kim@samsung.com>
Message-ID: <CACRpkdb6NDXqVicnRyQW8SPVHHo1hZ8OM57Ah3wmVwWWWp3+cg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 26, 2013 at 4:12 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:

> From: Thomas Abraham <thomas.ab@samsung.com>
>
> The property 'samsung,exynos5440-pins' is optional in configuration nodes
> which are included in the Exynos5440 pin-controller device node. Fix the
> incorrect failure in driver probe if 'samsung,exynos5440-pins' property
> is not found in the configuration nodes.
>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>

Patch applied!

Thanks,
Linus Walleij
