From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 25 Mar 2013 19:36:10 +0900
Subject: [PATCH 0/2] ARM: dts: Add default pin states for client nodes on
 Exynos4/5 platforms
In-Reply-To: <CACRpkdbsCpV5_P=z44CMvsgps=AS9C62oprn6To6ExhoWZkvhA@mail.gmail.com>
References: <1362573398-15126-1-git-send-email-thomas.abraham@linaro.org>
 <CACRpkdbsCpV5_P=z44CMvsgps=AS9C62oprn6To6ExhoWZkvhA@mail.gmail.com>
Message-ID: <17a201ce2944$91006440$b3012cc0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote:
> 
> On Wed, Mar 6, 2013 at 1:36 PM, Thomas Abraham
> <thomas.abraham@linaro.org> wrote:
> 
> > This patch series populates the default pin states in client nodes
> > of Exynos4 and Exynos5 platforms. Exynos4/5 platforms are migrating
> > to use pinctrl framework and having the default pin states listed
> > in the client nodes allows the device core to setup the default
> > pin configuration for all the controllers.
> 
> The series:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
Looks good to me, applied.

Thanks.

- Kukjin
