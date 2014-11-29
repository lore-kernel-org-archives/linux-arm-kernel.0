From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 29 Nov 2014 15:32:16 +0100
Subject: [RFC PATCH 4/5] ARM: enable linking against eventfd and irqchip
In-Reply-To: <CADDJ2=PoUa+ZNJ8grvZondPYQX31sZkGWxM9Jq7BN0JT9w_kXw@mail.gmail.com>
References: <20141124212240.10605.46770.stgit@i3820>
 <20141124212706.10605.50148.stgit@i3820>
 <54797337.2050001@huawei.com>
 <CADDJ2=PoUa+ZNJ8grvZondPYQX31sZkGWxM9Jq7BN0JT9w_kXw@mail.gmail.com>
Message-ID: <20141129143216.GB23653@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 29, 2014 at 03:49:37PM +0200, Nikolay Nikolaev wrote:
> On Sat, Nov 29, 2014 at 9:18 AM, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
> >
> > On 2014/11/25 5:27, Nikolay Nikolaev wrote:
> > > This enables compilation of the eventfd feature on ARM.
> > >
> >
> > Only enable on ARM? I think we should enable it on ARM64 as well because the eventfd featrue is common for ARM32 and ARM64.
> 
> If course - thanks for pointing this out.
> 
Please remember testing if this breaks anything on arm64 :)

-Christoffer
