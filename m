From: tony@atomide.com (Tony Lindgren)
Date: Tue, 29 Jul 2014 05:41:20 -0700
Subject: [PATCH 3/3] arm: dts: Add gta04a5 model
In-Reply-To: <1FA8171E-1B7A-4684-887E-11593BB9C29E@goldelico.com>
References: <1406577213-9642-1-git-send-email-marek@goldelico.com>
 <1406577213-9642-4-git-send-email-marek@goldelico.com>
 <CAOf5uwk=ctww=pP4Ae+1C6i-oOtiYTv2NJbj1GpuPwVSKXB4Hw@mail.gmail.com>
 <CAAfyv35jvhzvjCKMwrpa=RQ1JkfcmthCsGDzwLW9Y6bq3Ww_fg@mail.gmail.com>
 <CAOf5uw=Fm9FXEH5ESqDC8pGjMbn5VQ1+MyPJVXSqGh_9+JRLHw@mail.gmail.com>
 <1FA8171E-1B7A-4684-887E-11593BB9C29E@goldelico.com>
Message-ID: <20140729124120.GS29045@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dr. H. Nikolaus Schaller <hns@goldelico.com> [140728 13:45]:
> 
> Yes,
> the boot loader either loads gta04a3.dtb gta04.dtb or gta05.dtb
> depending on board revision.
> 
> Therefore we have multiple device tree files to represent such hardware
> differences. Like Gumstix Overo variants (using a  omap3-overo-base.dtsi)
> 
> And, this difference is not the only one. Other are to come later.
> 
> Unfortunately we were recommend to submit only DT nodes that already
> have drivers. Therefore, the "big picture" of the device variants support
> may not yet be visible from this patch.
> 
> I hope this gives a little background.

So what's the conclusion? Are changes needed to this patch
series or not?

Regards,

Tony
