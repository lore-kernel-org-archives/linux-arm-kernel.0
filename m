From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 30 Sep 2013 19:11:41 +0900
Subject: [PATCH v2 00/12] clk/exynos convert clock IDs to macros
In-Reply-To: <20130916193709.27384.86101@quantum>
References: <1378462361-13680-1-git-send-email-a.hajda@samsung.com>
 <8412301.YP2zzplWoe@amdc1227>
 <070001ceafa5$d4d81a40$7e884ec0$%kim@samsung.com>
 <523716C9.3000204@samsung.com> <20130916193709.27384.86101@quantum>
Message-ID: <06c101cebdc5$75a83d10$60f8b730$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike Turquette wrote:
> 
> Quoting Sylwester Nawrocki (2013-09-16 07:33:45)
> > On 09/12/2013 12:50 PM, Kukjin Kim wrote:
> > > Well...I'm not sure changing to use macro is better or not at this
> moment...
> >
> > I think it is. ;) It's really less error prone to have symbolic names
> instead
> > of the plain numbers. The clock ids are defined in one place and it is
> more
> > clear what a clock is by looking at symbolic name. It's especially
> annoying
> > to use plain numbers where are are many clock in a single node, like 10
> or
> > more. What are you main concerns with this ?
> 
> I think having the symbolic names is a win for readability.
> 
Hmm...since Mike who is a maintainer for ccf agrees with Sylwester's opinion, so I agree. Actually, I had no strong objection on this but still I'm not sure using macro is really better because sometimes the name doesn't give readability really I think though.

Mike, can you give me your ack on clk stuff?

Thanks,
Kukjin
