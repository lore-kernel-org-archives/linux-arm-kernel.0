From: sander@humilis.net (Sander)
Date: Wed, 29 Jan 2014 13:26:51 +0100
Subject: [PATCH] arm: Add Arm Erratum 773769 for Large data RAM latency.
In-Reply-To: <CAD=FV=XqoSGpQ_Yrjj4hvV_0FSMfQGcGEsKkL1Stnm9m5s2Xvw@mail.gmail.com>
References: <1389187991-26446-1-git-send-email-gautam.vivek@samsung.com>
 <20140108143529.GB14122@mudshark.cambridge.arm.com>
 <CAD=FV=WYe7Qk_XPs=FCeB7pbDz8AnG0txFcDyAQWWAU60vd-Sw@mail.gmail.com>
 <20140108192028.GM27432@n2100.arm.linux.org.uk>
 <CAD=FV=Ui8kec5vYA1jRT3EGNaUeWX-Ua5sUs+u3wdRz1oFnTzw@mail.gmail.com>
 <alpine.LFD.2.10.1401081600370.1851@knanqh.ubzr>
 <CAD=FV=XqoSGpQ_Yrjj4hvV_0FSMfQGcGEsKkL1Stnm9m5s2Xvw@mail.gmail.com>
Message-ID: <20140129122651.GB31980@panda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Doug Anderson wrote (ao):
> On Wed, Jan 8, 2014 at 1:08 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Wed, 8 Jan 2014, Doug Anderson wrote:
> >> * If Joe Upstream wants to run an upstream kernel on some type of
> >> exynos5250 product (Samsung ARM Chromebook, HP Chromebook 11, Nexus 10
> >> are the ones I know of) then he will deal with the small number of
> >> crashes or figure out a solution.
> >
> > If Joe Upstream wants to run an upstream kernel, doesn't he have to
> > unscrew his write protect switch first, at which point the RO firmware
> > can be updated as well?
> 
> Actually, no.  You can move your device into dev mode and run any
> kernel you want.  You'll get an annoying "you're in dev mode" screen
> at every bootup, but otherwise it works just fine.
> 
> Going into dev mode requires some special keystrokes at bootup and a
> wipe of your hard disk but no screwdrivers.

And there is http://www.arndaleboard.org/ where you just put an upstream
kernel on sd and boot.

	Sander
