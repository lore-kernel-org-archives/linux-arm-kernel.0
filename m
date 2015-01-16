From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 16 Jan 2015 10:04:48 +0000
Subject: [PATCH v7 00/17] Introduce ACPI for ARM64 based on ACPI 5.1
In-Reply-To: <54B8BB24.2020408@linaro.org>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <CACxGe6v_BvCQqp8d=LaQ8HeaOU1Zh_HPpwFTdwOjHUbqXsnQ8g@mail.gmail.com>
 <20150115182346.GE2329@e104818-lin.cambridge.arm.com>
 <54B8BB24.2020408@linaro.org>
Message-ID: <20150116100447.GB13634@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 16, 2015 at 07:17:56AM +0000, Hanjun Guo wrote:
> On 2015?01?16? 02:23, Catalin Marinas wrote:
> > On Thu, Jan 15, 2015 at 04:26:20PM +0000, Grant Likely wrote:
> >> On Wed, Jan 14, 2015 at 3:04 PM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> >>> This is the v7 of ACPI core patches for ARM64 based on ACPI 5.1
> >>
> >> I'll get right to the point: Can we please have this series queued up
> >> for v3.20?
> >
> > Before you even ask for this, please look at the patches and realise
> > that there is a complete lack of Reviewed-by tags on the code (well,
> > apart from trivial Kconfig changes). In addition, the series touches on
> > other subsystems like clocksource, irqchip, acpi and I don't see any
> > acks from the corresponding maintainers. So even if I wanted to merge
> 
> For the ACPI part, Rafael already said that "Having looked at the
> patches recently, I don't see any major problems in them from the ACPI
> core perspective, so to me they are good to go." [1]
> Is that kind of ack for this ?

I guess we can call this an "ack" from the ACPI core perspective. But
it's not just ACPI core that this series touches. You should probably
get a renewed ack for the latest series as the message you quoted is 4
months old.

A question that Rafael asked was how you plan to get these merged. You
(or Grant) chose the arm64 maintainers and that's fine by me but it
doesn't mean you don't need acks/reviews for the patches in this series.

-- 
Catalin
