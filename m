From: andi.shyti@samsung.com (Andi Shyti)
Date: Fri, 06 Jan 2017 22:53:57 +0900
Subject: [PATCH v5 2/5] arm64: dts: exynos: make tm2 and tm2e independent
 from each other
In-Reply-To: <20170106134929.mj7wqalp7lpkfm6b@kozik-lap>
References: <20170106134350.32428-1-andi.shyti@samsung.com>
 <CGME20170106134356epcas1p19be459900aec43b2b9ea343cdaf0a2bf@epcas1p1.samsung.com>
 <20170106134350.32428-3-andi.shyti@samsung.com>
 <20170106134929.mj7wqalp7lpkfm6b@kozik-lap>
Message-ID: <20170106135357.n4ugkcdcog4hzbhe@gangnam.samsung>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

> > -#include "exynos5433-tm2.dts"
> > +#include "exynos5433-tm2-common.dtsi"
> >  
> >  / {
> >  	model = "Samsung TM2E board";
> 
> Where are the regulators?

No need, they were already overwriting the original property, so
with your suggestion they didn't change in tm2e. That's why I like
your suggestion.

Originally I added the 'regulator' label to not have empty nodes.

Andi
