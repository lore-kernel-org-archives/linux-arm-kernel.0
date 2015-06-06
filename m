From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 5 Jun 2015 17:45:54 -0700
Subject: [PATCH v3 0/3] clk: meson: Add clock controller
In-Reply-To: <CAOQ7t2YtMrX9QQHGiCvoPb9SSdvBvzXSu4e7wnzC7eCdUaiWwg@mail.gmail.com>
References: <1433157235-17275-1-git-send-email-carlo@caione.org>
 <20150604230717.GE8099@codeaurora.org>
 <CAOQ7t2YtMrX9QQHGiCvoPb9SSdvBvzXSu4e7wnzC7eCdUaiWwg@mail.gmail.com>
Message-ID: <20150606004554.GB29237@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05, Carlo Caione wrote:
> On Fri, Jun 5, 2015 at 1:07 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > On 06/01, Carlo Caione wrote:
> >> From: Carlo Caione <carlo@endlessm.com>
> >>
> >> This patchset introduces preliminary support for the clock controller
> >> found on Amlogic MesonX SoCs and enables it for the Meson8b.
> >>
> >> DTS patches with support for Meson8b SoCs will follow.
> >>
> >
> > Did you want to send the dts changes through arm-soc?
> 
> (adding Arnd in CC) this is what I have done in the past but I have no
> strong preference.
> 
> > Do they depend on the header file that is included here?
> 
> Yes, they do.
> 
> > clk-next is not
> > stable and shouldn't be pulled into other developer's trees, so
> > if we need some stable commit to give off to arm-soc for v4.2
> > we need to know soon. Or we can split the header file off into a
> > different patch and send it through both arm-soc and clk tree.
> 
> Again whatever is more preferable to the maintainers. Just let me know
> so I can rearrange the DTS patchset.
> 

I'd prefer not to send dts changes through the clk tree either. I
looked for the dts changes on the list but I couldn't find them.

I've put these patches on a 'clk-meson8b' branch and merged it
into clk-next. We won't rewrite clk-meson8b so you can use it for
a stable baseline to send to arm-soc if needed.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
