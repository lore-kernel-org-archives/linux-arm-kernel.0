From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 25 Mar 2013 19:40:34 +0900
Subject: [PATCH 0/2] ARM: dts: Add default pin states for client nodes on
 Exynos4/5 platforms
In-Reply-To: <514FF37F.7090405@linaro.org>
References: <1362573398-15126-1-git-send-email-thomas.abraham@linaro.org>
 <CACRpkdbsCpV5_P=z44CMvsgps=AS9C62oprn6To6ExhoWZkvhA@mail.gmail.com>
 <514FF37F.7090405@linaro.org>
Message-ID: <17a301ce2945$2dfc3a30$89f4ae90$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tushar Behera wrote:
> 
> On 03/07/2013 01:45 PM, Linus Walleij wrote:
> > On Wed, Mar 6, 2013 at 1:36 PM, Thomas Abraham
> > <thomas.abraham@linaro.org> wrote:
> >
> >> This patch series populates the default pin states in client nodes
> >> of Exynos4 and Exynos5 platforms. Exynos4/5 platforms are migrating
> >> to use pinctrl framework and having the default pin states listed
> >> in the client nodes allows the device core to setup the default
> >> pin configuration for all the controllers.
> >
> > The series:
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > Yours,
> > Linus Walleij
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-samsung-
> soc" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> Kukjin,
> 
> Would you be applying this patch-set to your tree? We need that to
> rebase Arndale related patches for v3.10.
> 
Just note, you will see this series late tomorrow because I need to sort out
samsung tree.

Thanks for your reminder.

- Kukjin
