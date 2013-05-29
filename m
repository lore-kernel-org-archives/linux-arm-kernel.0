From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 29 May 2013 16:16:49 -0700
Subject: [PATCH 4/4] MAINTAINERS: vt8500: Add clk-vt8500.c to MAINTAINERS
 file
In-Reply-To: <51973C1D.2080404@prisktech.co.nz>
References: <1368825532-30917-1-git-send-email-linux@prisktech.co.nz>
 <1368825532-30917-5-git-send-email-linux@prisktech.co.nz>
 <CABjd4Yw2LbnaUbQFW_bd_6WRGTA34-Vp_tUC2b4Jczj-MM8x1w@mail.gmail.com>
 <51973C1D.2080404@prisktech.co.nz>
Message-ID: <20130529231649.6058.4589@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Tony Prisk (2013-05-18 01:30:21)
> On 18/05/13 18:40, Alexey Charkov wrote:
> > On 18 May 2013 01:18, "Tony Prisk" <linux@prisktech.co.nz> wrote:
> >> This file has missed being added under ARM/VT8500 ARM ARCHITECTURE,
> >> and is maintained along with the rest of the vt8500 arch code.
> >>
> >> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> >> ---
> >>   MAINTAINERS |    1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 3d7782b..5ab8ccb 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -1283,6 +1283,7 @@ M:        Tony Prisk <linux@prisktech.co.nz>
> >>   L:     linux-arm-kernel at lists.infradead.org (moderated for
> > non-subscribers)
> >>   S:     Maintained
> >>   F:     arch/arm/mach-vt8500/
> >> +F:     drivers/clk/vt8500-vt8500.c
> > This looks like a typo (clk vs. vt8500).
> >
> > Best,
> > Alexey
> >
> eeek - oops.
> 
> Mike,
> 
> Disregard this patch - I will send a more complete one through arm-soc 
> as there are other files missing as well.
> 

Hi Tony,

I've taken patch #1 into clk-fixes.  I took patches #2 & #3 into
clk-next from your previous series posted on May 13, which appear
identical to the ones in this series.  In the future could you put a
"v2" in the patch subject since those patches were re-posted?  It would
have helped me catch it.

I have not taken patch #4.

Does this all sound correct to you?

Thanks,
Mike

> Regards
> Tony P
