From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 28 Aug 2015 12:46:05 +0200
Subject: [PATCH] clk: samsung: fix cpu clock's flags checking
In-Reply-To: <CABxcv=kVL94rdFgNKcxx2JOi9WRFnvhMWrpjEDcEmx7q7cEsgQ@mail.gmail.com>
References: <1435598978-21800-1-git-send-email-b.zolnierkie@samsung.com>
 <5591DD9B.4030507@samsung.com>
 <CABxcv=kVL94rdFgNKcxx2JOi9WRFnvhMWrpjEDcEmx7q7cEsgQ@mail.gmail.com>
Message-ID: <7248406.UkvN4Bv1cx@amdc1976>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Michael/Sylwester, could you please merge this patch?

It is a bugfix for ddeac8d968d41d13a52582d6e80395a329e9b1ff ("clk:
samsung: add infrastructure to register cpu clocks") which got
merged in v4.2-rc1.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

On Tuesday, June 30, 2015 08:27:36 AM Javier Martinez Canillas wrote:
> On Tue, Jun 30, 2015 at 2:06 AM, Krzysztof Kozlowski
> <k.kozlowski@samsung.com> wrote:
> > On 30.06.2015 02:29, Bartlomiej Zolnierkiewicz wrote:
> >> CLK_CPU_HAS_DIV1 and CLK_CPU_NEEDS_DEBUG_ALT_DIV masks were
> >> incorrectly used as a bit numbers.  Fix it.
> >>
> >> Tested on Exynos4210 based Origen board and on Exynos5250 based
> >> Arndale board.
> >>
> >> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> >> Cc: Michael Turquette <mturquette@baylibre.com>
> >> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> >> Cc: Thomas Abraham <thomas.ab@samsung.com>
> >> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> >> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> >> ---
> >>  drivers/clk/samsung/clk-cpu.c | 10 +++++-----
> >>  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> >
> 
> Looks good to me as well.
> 
> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> 
> > Best regards,
> > Krzysztof
> >
> 
> Best regards,
> Javier
