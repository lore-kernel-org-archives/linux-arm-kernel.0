From: mturquette@linaro.org (Mike Turquette)
Date: Sun, 23 Feb 2014 15:43:57 -0800
Subject: [PATCH 2/2] clk: ux500: Staticize ux500_twocell_get
In-Reply-To: <CAPDyKFqJyx7bCF0bYeBPawNBJORPiMBXtg7hyr33UK=JxPGWaA@mail.gmail.com>
References: <1389764606-14102-1-git-send-email-sachin.kamat@linaro.org>
 <1389764606-14102-2-git-send-email-sachin.kamat@linaro.org>
 <20140115073631.GD11820@lee--X1>
 <CAPDyKFro5Zf-WoCANshvwSRCkwMKp26tCuatUzp2TvMEh1Qhxg@mail.gmail.com>
 <CAPDyKFqJyx7bCF0bYeBPawNBJORPiMBXtg7hyr33UK=JxPGWaA@mail.gmail.com>
Message-ID: <20140223234357.22529.40501@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Ulf Hansson (2014-02-23 07:39:11)
> On 20 January 2014 12:45, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On 15 January 2014 08:36, Lee Jones <lee.jones@linaro.org> wrote:
> >>> ux500_twocell_get is a local symbol.
> >>>
> >>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> >>> Cc: Lee Jones <lee.jones@linaro.org>
> >>> ---
> >>>  drivers/clk/ux500/u8500_of_clk.c |    3 ++-
> >>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> Acked-by: Lee Jones <lee.jones@linaro.org>
> >>
> >
> > Thanks! Pushed to my clk-next-ux500 branch.
> 
> Mike, would you be kind to pick this patch with my ack? Currently I
> have no more than this one for ux500 for 3.15.

No problem. Merged to clk-next with your and Lee's Ack.

Regards,
Mike

> 
> Kind regards
> Ulf Hansson
> 
> >
> > Kind regards
> > Ulf Hansson
> >
> >> --
> >> Lee Jones
> >> Linaro STMicroelectronics Landing Team Lead
> >> Linaro.org ? Open source software for ARM SoCs
> >> Follow Linaro: Facebook | Twitter | Blog
> >>
> >> _______________________________________________
> >> linux-arm-kernel mailing list
> >> linux-arm-kernel at lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
