From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 20 Dec 2012 19:38:53 -0800
Subject: linux-next: manual merge of the arm-soc tree with the pinctrl tree
In-Reply-To: <20121221132014.0bf8772fb3e48c51cec1548a@canb.auug.org.au>
References: <20121221132014.0bf8772fb3e48c51cec1548a@canb.auug.org.au>
Message-ID: <027101cddf2c$b4f2f9b0$1ed8ed10$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Rothwell wrote:
> 
> Hi all,
> 
> Today's linux-next merge of the arm-soc tree got conflicts in
> drivers/pinctrl/pinctrl-exynos5440.c and
> drivers/pinctrl/pinctrl-samsung.c between commit e5b4c9d4ab55 ("pinctrl:
> exynos5440: Fix compile error in pinctrl-exynos5440/samsung.c") from the
> pinctrl tree and commit d5fd5da290ce ("pinctrl: exynos5440/samsung:
> Staticize pcfgs") from the arm-soc tree.
> 
Oops, the commit d5fd5da290ce already sent to Linus Torvalds via arm-soc
tree today. In addition, I applied with Linus Walleij's ack ;-)

Linus Walleij, please drop the patch in your tree. Sorry I didn't notify
about that when I got the patch from Choi.

Thanks.

- Kukjin

> The former is a superset of the latter, so I used that (no action
> is required).
> 
> --
> Cheers,
> Stephen Rothwell                    sfr at canb.auug.org.au
