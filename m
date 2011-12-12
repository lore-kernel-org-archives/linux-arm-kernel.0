From: boojin.kim@samsung.com (Boojin Kim)
Date: Mon, 12 Dec 2011 15:46:53 +0900
Subject: [PATCH] ARM: MM: Configure the number of banks
In-Reply-To: <20111211102443.GT14542@n2100.arm.linux.org.uk>
References: <1323048539-9573-1-git-send-email-boojin.kim@samsung.com>
 <20111211100325.GR14542@n2100.arm.linux.org.uk>
 <20111211102443.GT14542@n2100.arm.linux.org.uk>
Message-ID: <006901ccb899$d5c33930$8149ab90$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King wrote:


> >
> >  source arch/arm/mm/Kconfig
> >
> > +config ARM_NR_BANKS
> > +	int
> > +	default 16 if ARCH_EP93XX
>
> I've now committed this patch - if you want to add exynos to this,
> please send a patch to do just that.  Thanks.

It's good to me.
Thank you for review !
