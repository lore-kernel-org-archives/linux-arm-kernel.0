From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 23 Jul 2013 09:01:38 -0700
Subject: [PATCH] pinctrl: fix a memleak when freeing maps
In-Reply-To: <1374536739-18966-1-git-send-email-linus.walleij@linaro.org>
References: <1374536739-18966-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <51EEA8E2.6020003@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/22/2013 04:45 PM, Linus Walleij wrote:
> We forgot to free the node itself when free:ing a map.
> 
> Reported-by: xulinuxkernel <xulinuxkernel@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Stephen Warren <swarren@nvidia.com>

The full name in the reported-by doesn't look accurate, but I suppose
that isn't an s-o-b entry, so it's not a big deal.
