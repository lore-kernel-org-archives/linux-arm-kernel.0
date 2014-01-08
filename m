From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 08 Jan 2014 01:37:27 +0100
Subject: [PATCH 6/7] clk/samsung: add support for pll2650xx
In-Reply-To: <CAPdUM4P9tE5ohtAb5heMRj3GGjdYrNYp5iX7u-uZySiaCikA7Q@mail.gmail.com>
References: <1386345391-23482-1-git-send-email-rahul.sharma@samsung.com>
 <1419145.DZQg0ZkHVU@amdc1227>
 <CAPdUM4P9tE5ohtAb5heMRj3GGjdYrNYp5iX7u-uZySiaCikA7Q@mail.gmail.com>
Message-ID: <3338407.XGYaxCsdnx@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 06 of January 2014 17:14:48 Rahul Sharma wrote:
> Hi Tomasz,
> 
> On 19 December 2013 17:15, Tomasz Figa <t.figa@samsung.com> wrote:
> > Hi Rahul,
> >
> > On Friday 06 of December 2013 21:26:30 Rahul Sharma wrote:
> >> Add support for pll2650xx in samsung pll file. This pll variant
> >> is close to pll36xx but uses CON2 registers instead of CON1.
> >
> > If the ops are otherwise idential, why not reuse the ops for pll36xx
> > and use CON1 or CON2 register conditionally based on pll->type field?
> > (Just as it is already done for pll4600, 4650 and 4650c.)
> >
> 
> I verified the difference and found that  pll2650xx is fairly
> different in terms of
> Bit Fields, Con2 register, and additional PLL config bits than pll36xx. Due to
> this, I have to add lot of if-else code based on pll type which
> doesn't looks clean.

Fair enough.

Best regards,
Tomasz
