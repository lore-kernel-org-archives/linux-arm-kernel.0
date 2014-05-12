From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 12 May 2014 16:55:00 -0700
Subject: [PATCH] clk: shmobile: clk-mstp: change to using clock-indices
In-Reply-To: <CAMuHMdVCYCt5gogociqBk7xGaD97oX8sm4oaqRVyrrRzEKuLmQ@mail.gmail.com>
References: <1397577994-12061-1-git-send-email-ben.dooks@codethink.co.uk>
 <20140505225013.5739.23946@quantum>
 <CAMuHMdXO=WJjNSsWbKx5KxrF3w9VgEyEj3kdiSN1AyxaHFKpFw@mail.gmail.com>
 <CAMuHMdVCYCt5gogociqBk7xGaD97oX8sm4oaqRVyrrRzEKuLmQ@mail.gmail.com>
Message-ID: <20140512235500.5943.46685@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Geert Uytterhoeven (2014-05-12 01:31:41)
> Hi Mike,
> 
> On Tue, May 6, 2014 at 1:43 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, May 6, 2014 at 12:50 AM, Mike Turquette <mturquette@linaro.org> wrote:
> >> Quoting Ben Dooks (2014-04-15 09:06:34)
> >>> With the addition of clock-indices, we need to change the renesas
> >>> clock implementation to use these instead of the local definition
> >>> of "renesas,clock-indices".
> >>>
> >>> Since this will break booting with older device trees, we add a
> >>> simple auto-detection of which properties are present.
> >>>
> >>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> >>
> >> I'm fine to take this into clk-fixes, destined for 3.15-rc5. Does that
> >
> > Thanks!
> 
> It seems this missed rc5?
> Can you please submit for rc6?

Yes, I will send out the PR for that today. This fix has already landed
in clk-next as I merge the clk-fixes branch into clk-next regularly.

Regards,
Mike

> 
> Thanks again!
> 
> >> solve the issues on your end? Do you still need me to host a stable
> >> topic branch for you? I'm happy to do that if needed.
> >
> > As Simon will be on holidays until rc5, I think he can just use rc5 as the
> > stable base for further fixes.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
