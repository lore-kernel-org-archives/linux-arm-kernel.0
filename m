From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 30 Sep 2010 19:48:03 +0900
Subject: [PATCH 7/7] ARM: S5PC210: I2C{3, 4, 5, 6, 7} device support
In-Reply-To: <AANLkTikgXpJPnbQGchvHSCTshKzAO5GJyGHio=6Q0RZJ@mail.gmail.com>
References: <20100930044859.GA16923@july>
	<000b01cb6067$99850240$cc8f06c0$%seo@samsung.com>
	<AANLkTinC9U3mehOVGWSM26TjMVyx9o6fBgLrXUKQmOcb@mail.gmail.com>
	<AANLkTik9Q7e=nzOmKsxEBeeJn-5JcQpKJfTSfGqLB21G@mail.gmail.com>
	<AANLkTin9tR4+CBa+r6mHsJdFYxzkaK1CA+_WKhTZkacs@mail.gmail.com>
	<006601cb6081$bf8a7140$3e9f53c0$%han@samsung.com>
	<AANLkTikmTyOnmA7eaN0_Vysf+0BviDX428MhZHTffpe7@mail.gmail.com>
	<006b01cb6088$ffc17b80$ff447280$%han@samsung.com>
	<AANLkTikgXpJPnbQGchvHSCTshKzAO5GJyGHio=6Q0RZJ@mail.gmail.com>
Message-ID: <00a001cb608c$f94de230$ebe9a690$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> On Thu, Sep 30, 2010 at 7:19 PM, Jongsun Han <jongsun.han@samsung.com>
> wrote:
> > On Thu, Sep 30, 2010 at 6:27 PM, Jongsun Han <jongsun.han@samsung.com>
> >> wrote:
> >> > On Thu, Sep 30, 2010 at 3:50 PM, Jassi Brar
<jassisinghbrar@gmail.com>
> >> wrote:
> >> >> > On Thu, Sep 30, 2010 at 3:27 PM, Kyungmin Park
> <kmpark@infradead.org>
> >> wrote:
> >> >> >> On Thu, Sep 30, 2010 at 3:20 PM, Jeongbae Seo
> >> <jeongbae.seo@samsung.com>
> >> >> wrote:
> >> >> >>> Kyungmin wrote:
> >> >> >>>> From: Kyungmin Park <kyungmin.park@samsung.com>
> >> >> >>>>
> >> >> >>>> S5PC210 support more I2C devices than previous SoCs.
> >> >> >>>> And to prevent the wrong usage use the s5p prefix instead of
s3c.
> >> >> >>>>
> >> >> >>>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> >> >> >>>> ---

(snip)

> To Kgene,
> Any comments? I think you already mentioned that don't use #ifdef ~
> #endif at c files if possible.
> In this case are you okay?
> 
Hi :-)

I know his patch will be submitted soon...maybe tomorrow?
So how about talking about that tomorrow?

And...we should support it with any method...
Let's make good output together.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
