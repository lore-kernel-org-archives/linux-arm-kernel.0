From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 26 Sep 2013 14:29:13 +0900
Subject: [PATCH v2] ARM: SAMSUNG: S5P: If detected device tree skip irq
 init
In-Reply-To: <2123658.6S6hP57GRg@flatron>
References: <1380038363-487-1-git-send-email-m.krawczuk@partner.samsung.com>
 <2123658.6S6hP57GRg@flatron>
Message-ID: <02c901ceba79$55b382c0$011a8840$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:
> 
> Hi Mateusz,
> 
> On Tuesday 24 of September 2013 17:59:23 Mateusz Krawczuk wrote:
> > It prevents from executing things already handled by pinctrl-exynos
> > driver, when device tree is available.
> >
> > Signed-off-by: Mateusz Krawczuk <m.krawczuk@partner.samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> >  arch/arm/plat-samsung/s5p-irq-eint.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> 
> Acked-by: Tomasz Figa <t.figa@samsung.com>
> 
> [as a temporary solution until we move all the users of this code to
> device tree]
> 
Yes, agreed.

The 'skip irq init' in subject would be changed to 'skip eint init' for
clear meaning.

Applied.

Thanks,
Kukjin
