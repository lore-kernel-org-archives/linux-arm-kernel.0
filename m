From: pullip.cho@samsung.com (Cho KyongHo)
Date: Wed, 19 Mar 2014 17:46:17 +0900
Subject: [PATCH v11 13/27] iommu/exynos: support for device tree
In-Reply-To: <CAK9yfHy+uiRPZjEDzZRpNKVY1CnWehVGdJmu3ztOTXAuHBx_Yg@mail.gmail.com>
References: <20140314140935.e0652b58ce16591b54d0e10b@samsung.com>
 <CAK9yfHx_FUaUcA_tpsJ73i0iJmczOp7K8gC6sMGHQ6c50i46=A@mail.gmail.com>
 <20140318201424.e8bde8514726c3639243e9ad@samsung.com>
 <CAK9yfHy+uiRPZjEDzZRpNKVY1CnWehVGdJmu3ztOTXAuHBx_Yg@mail.gmail.com>
Message-ID: <20140319174617.e5ad5ca5547900dce2ecfa74@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Mar 2014 16:46:24 +0530, Sachin Kamat wrote:
> On 18 March 2014 16:44, Cho KyongHo <pullip.cho@samsung.com> wrote:
> > On Fri, 14 Mar 2014 20:57:42 +0530, Sachin Kamat wrote:
> >> Hi KyongHo,
> >>
> >> On 14 March 2014 10:39, Cho KyongHo <pullip.cho@samsung.com> wrote:
> >> >
> >> > -static struct platform_driver exynos_sysmmu_driver = {
> >> > -       .probe          = exynos_sysmmu_probe,
> >> > -       .driver         = {
> >> > +#ifdef CONFIG_OF
> >>
> >> This is not needed as Exynos is DT only platform.
> >>
> > Yes, but I hesitate to remove that.
> 
> What is the reason for your hesitation? :)
> 
Actually, no reason because you mentioned that Exynos is DT only platofrm.

I will remove that.

Thank you.

KyongHo
