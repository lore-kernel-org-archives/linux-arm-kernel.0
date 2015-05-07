From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 7 May 2015 19:32:41 +0800
Subject: not syncing: Attempted to kill init! exitcode=0x00000004 ?
In-Reply-To: <CAK7LNAQmdgowKRLJnf2jcz8BxLoaJKfwTSkNH8R_1Grc9Gt4ng@mail.gmail.com>
References: <CAK7LNATT8cJoQh+7ZEyUXgMtL0OSYg+69t8wcuNSk+SN+Rwf2g@mail.gmail.com>
 <20150505115446.GA26467@dragon>
 <CAAQ0ZWRyndnoSs5D+AcOZB-7hSnhSULTYVu=TRtcGR-CfB9xGQ@mail.gmail.com>
 <CAK7LNAQmdgowKRLJnf2jcz8BxLoaJKfwTSkNH8R_1Grc9Gt4ng@mail.gmail.com>
Message-ID: <20150507113239.GE3162@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 07, 2015 at 11:30:25AM +0900, Masahiro Yamada wrote:
> Hi Shawn,
> (Sorry for late reply, I's been a vacation in Japan.)
> 
> 
> 2015-05-06 17:56 GMT+09:00 Shawn Guo <shawn.guo@linaro.org>:
> > On Tue, May 5, 2015 at 7:54 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> >> On Tue, Apr 07, 2015 at 12:34:30PM +0900, Masahiro Yamada wrote:
> >>> Hello experts,
> >>> I hope this is the correct ML to ask this question.
> >>>
> >>> I am struggling to port Linux-4.0-rc7 onto my SoC/board,
> >>> based on ARM cortex-A9 (single CPU), but the kernel fails to boot
> >>> with the error:
> >>> "not syncing: Attempted to kill init! exitcode=0x00000004"
> >>
> >> Hi Masahiro,
> >>
> >> Have you track it down to the cause?  I'm asking because I'm seeing the
> >> same issue with v4.0 on a vendor single Cortex-A9 SoC.
> 
> Yes, I have already solved my problem.
> 
> In my case,
> 
>  - The interrupt number for the UART device was wrong.  Fixed it.
>  - I regenerated the initramdisk with Buildroot
> 
> and then I could boot the kernel successfully.

Thanks for the update, Masahiro.

Shawn
