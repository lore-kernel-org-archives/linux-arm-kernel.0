From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 19 Dec 2013 01:36:11 +0100
Subject: [PATCH 2/3] clk: exynos5250: fix sysmmu_mfc{l,r} gate clocks
In-Reply-To: <20131218192430.23538.93253@quantum>
References: <1383905648-23733-1-git-send-email-sachin.kamat@linaro.org>
 <CA+Ln22GD5fr4S6aR-+85bdutkeeHmgutLvRWETEQEt1vJX-Y6Q@mail.gmail.com>
 <20131218192430.23538.93253@quantum>
Message-ID: <2195944.NGxsB7RHkr@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 of December 2013 11:24:30 Mike Turquette wrote:
> Quoting Tomasz Figa (2013-12-18 10:28:57)
> > Hi Sachin,
> > 
> > 2013/12/18 Sachin Kamat <sachin.kamat@linaro.org>:
> > > Hi Tomasz,
> > >
> > > On 10 November 2013 22:38, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> > >> Hi Sachin, Andrew,
> > >>
> > >> On Friday 08 of November 2013 15:44:07 Sachin Kamat wrote:
> > >>> From: Andrew Bresticker <abrestic@chromium.org>
> > >>>
> > >>> The gate clocks for the MFC sysmmus appear to be flipped, i.e.
> > >>> GATE_IP_MFC[2] gates sysmmu_mfcl and GATE_IP_MFC[1] gates sysmmu_mfcr.
> > >>> Fix this so that the MFC will start up.
> > >>
> > >> Wow, this means that there is a mistake in the documentation. Not that
> > >> I'm surprised, though.
> > >>
> > >> I guess you are sure about this, so:
> > >>
> > >> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> > >
> > > I believe you are going to take this through your tree along with a
> > > few others which you have already reviewed?
> > 
> > Thanks for reminding me about this patch. It's been quite a while
> > since it was posted
> > to the list.
> > 
> > Yes, I will apply it to samsung-clk tree.
> 
> Feel free to add my Ack when you apply it. Will these be sent later as a
> pull request for the clk tree?

Yes. That's the plan. :)

Best regards,
Tomasz
