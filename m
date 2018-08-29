From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Wed, 29 Aug 2018 11:10:14 +0900
Subject: [PATCH] devfreq: Convert to using %pOFn instead of
 device_node.name
In-Reply-To: <5B84AE40.50305@samsung.com>
References: <5B84AE40.50305@samsung.com>
 <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-15-robh@kernel.org>
 <CGME20180828015312epcas2p2fdb2ee1d1b292f212ec773dd8fb4bfc7@epcms1p8>
Message-ID: <20180829021014epcms1p85b74efd54e73039e5a81629d8079e02e@epcms1p8>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Dear Rob,
> 
> On 2018? 08? 28? 10:52, Rob Herring wrote:
> > In preparation to remove the node name pointer from struct device_node,
> > convert printf users to use the %pOFn format specifier.
> > 
> > Cc: Chanwoo Choi <cw00.choi@samsung.com>
> > Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> > Cc: Kyungmin Park <kyungmin.park@samsung.com>
> > Cc: Kukjin Kim <kgene@kernel.org>
> > Cc: Krzysztof Kozlowski <krzk@kernel.org>
> > Cc: linux-pm at vger.kernel.org
> > Cc: linux-arm-kernel at lists.infradead.org
> > Cc: linux-samsung-soc at vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/devfreq/event/exynos-ppmu.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
[]
> 
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
