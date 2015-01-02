From: tony@atomide.com (Tony Lindgren)
Date: Fri, 2 Jan 2015 09:11:23 -0800
Subject: [PATCH v5 0/4] Fixes for SDIO interrupts for dw_mmc
In-Reply-To: <CAD=FV=UzJo=KE7Snb2v=dNodmf_ky97o3xyUHUAZqb1Kq10d1A@mail.gmail.com>
References: <1417563767-32181-1-git-send-email-dianders@chromium.org>
 <CAPDyKFpxvE4x_-PV=KN0HKY5cNug-ss9m5KCjNdebR1LDOJi5w@mail.gmail.com>
 <CAD=FV=UCyOXfMqu_MYbd5pKOpgXPB87LQ7hCegeeY9vzsy6QAg@mail.gmail.com>
 <CAPDyKFqGW2NaN+5mUrpBWrhM5ZfUSx70-Yyk9qmNaC1ft_ibpw@mail.gmail.com>
 <CAD=FV=UzJo=KE7Snb2v=dNodmf_ky97o3xyUHUAZqb1Kq10d1A@mail.gmail.com>
Message-ID: <20150102171123.GC3298@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Doug Anderson <dianders@chromium.org> [150102 09:09]:
> Ulf,
> 
> On Tue, Dec 30, 2014 at 2:29 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >>> In v5, I don't find a patch 1/4. Anyway, I have taken patch 2->4.
> >>
> >> Ah, maybe because it wasn't sent to linux-mmc?  I messed that up and
> >> will try to do better in the future.  Sorry.  :(  You were in the To
> >> line, though.  You can see at
> >> <https://patchwork.kernel.org/patch/5425241/>.
> >>
> >> Do you want me to repost it and CC linux-mmc with Tony's Ack?
> >
> > I suggest you have a look at my next branch and to verify that I
> > haven't screwed things up. If so, either I should drop the patches and
> > you make a resend or if it's possible to just send an incremental path
> > on top?
> 
> The patches that landed look good to me, but I think you might break
> omap3pandora's WiFi until you land patch #1 in the series.  It has
> Tony's Ack so I think he intends for you to land it in your tree.
> 
> [v5,1/4] ARM: OMAP2+: Make sure pandora_wl1251_init_card() applies to SDIO only

Yes please pick that one up too to avoid breakage. The changes to the
mach-omap2/board-*.c files are only minimal fixes, so it should not
conflict with anything I'll be applying.

Regards,

Tony
