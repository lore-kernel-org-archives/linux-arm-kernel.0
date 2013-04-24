From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 24 Apr 2013 16:47:08 +0200
Subject: [PATCH 2/2] pinctrl: samsung: Fix link error with
 CONFIG_PINCTRL_EXYNOS disabled
In-Reply-To: <CACRpkdZmSj-AqUA9kd7NMN6cL2Nxa0EaKoSVkwQSrxhcWEeQtg@mail.gmail.com>
References: <1366060483-20342-1-git-send-email-tomasz.figa@gmail.com>
 <6940961.67Lk2axxPL@amdc1227>
 <CACRpkdZmSj-AqUA9kd7NMN6cL2Nxa0EaKoSVkwQSrxhcWEeQtg@mail.gmail.com>
Message-ID: <2113989.KXXvDDhnMa@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 of April 2013 16:27:09 Linus Walleij wrote:
> On Tue, Apr 23, 2013 at 2:09 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> > On Tuesday 23 of April 2013 14:03:12 Linus Walleij wrote:
> >> This does not apply to my "devel" branch in the pinctrl tree.
> >> 
> >> Could you rebase it on that branch?
> >> 
> >> Or is the error not even in my tree?
> > 
> > This one got sent incorrectly due to my mistake. Please try the correct
> > version:
> > 
> > [PATCH RESEND 2/2] pinctrl: samsung: Fix link error with
> > CONFIG_PINCTRL_EXYNOS disabled
> 
> This does not apply either.
> 
> Can you please test against the "devel" branch in the pinctrl tree?

Right, it does not apply.

Well, actually it does with git am -3, but it is incorrect, since the problem 
it intends to fix is not present in your tree, but rather is a merge error in 
linux-next in a merge of Kgene's and your tree...

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
SW Solution Development, Kernel and System Framework
