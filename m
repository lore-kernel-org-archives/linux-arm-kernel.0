From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 21 Jun 2010 18:36:13 +0800
Subject: Samsung SoCs naming rules
In-Reply-To: <AANLkTiljyiQohHVJxUsn7Q6_IwTZk2AdNlLRxgGmxNpQ@mail.gmail.com>
References: <AANLkTiljyiQohHVJxUsn7Q6_IwTZk2AdNlLRxgGmxNpQ@mail.gmail.com>
Message-ID: <AANLkTilnjN1dBWPKCuDt_bg8-5GEuSCrOh7vhqGf-VQU@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 21, 2010 at 6:00 PM, Kyungmin Park <kmpark@infradead.org> wrote:
> Dear all,
>
> Now Samsung SoCs doesn't have any special rules include chip name.
>
> Historically s5pc100 is successor form s3c6410 and this chip from
> s3c2410 series.
> on the other hand, s5pc110 (cortex a8) and s5pc64xx (armv6) is
> different from previous chips.

Don't be shy, Samsung is not the only vendor messes the naming of their
SoCs. Marvell might have done a better job on this :-)

>
> So it's not good idea grouping with the prefix. e.g., s5p series. and
> the reason to create the samsung.
>

My guess is your s5p will focus more on Cortex-A8 (or A9 possibly),
even with subsequent processors. And only s5pc100 is an exception,
that's fine, you can still put s5pc100 into mach-s3c6410, and people
will know it's actually closer to s3c6410. And other SoCs will share the
common s5p prefix.

> we tried to find a common name several times but failed to get proper
> name, I hope community give good name rules.
