From: marek.vasut@gmail.com (Marek Vasut)
Date: Sun, 23 Jan 2011 14:08:19 +0100
Subject: colibri-pxa300 USB patch
In-Reply-To: <AANLkTinN7TyOaj9=-8eXtrJPzf=iZdvqJOBMwyS=9D=c@mail.gmail.com>
References: <AANLkTikN2bqq7khp4mvqmfH=14Gzewd1da=2OGLJcnTZ@mail.gmail.com>
	<201101231212.27627.marek.vasut@gmail.com>
	<AANLkTinN7TyOaj9=-8eXtrJPzf=iZdvqJOBMwyS=9D=c@mail.gmail.com>
Message-ID: <201101231408.19511.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 23 January 2011 13:49:41 Bj?rn Forsman wrote:
> 2011/1/23 Marek Vasut <marek.vasut@gmail.com>:
> > On Wednesday 22 December 2010 20:30:10 Bj?rn Forsman wrote:
> >> Hi,
> >> 
> >> 2010/12/22 Eric Miao <eric.y.miao@gmail.com>:
> >> > 2010/12/22 Bj?rn Forsman <bjorn.forsman@gmail.com>:
> >> >> Hi,
> >> >> 
> >> >> 2010/12/22 Eric Miao <eric.y.miao@gmail.com>:
> >> >>> 2010/12/22 Bj?rn Forsman <bjorn.forsman@gmail.com>:
> >> >>>> Hi Eric,
> >> >>>> 
> >> >>>> 2010/12/21 Bj?rn Forsman <bjorn.forsman@gmail.com>:
> >> >>>>> Hi Eric,
> >> >>>>> 
> >> >>>>> 2010/12/21 Eric Miao <eric.y.miao@gmail.com>:
> >> >>>>>> This has been merged by Marek and cherry-picked into my devel,
> >> >>>>>> thanks.
> >> >>>>> 
> >> >>>>> Thanks.
> >> >>>> 
> >> >>>> Oh, and one more thing:
> >> >>>> 
> >> >>>> Russell King syncs his tree with Linus every two days[1][2] which
> >> >>>> means ARM developers can/should base their patches on mainline.
> >> >>>> I didn't find any similar information on how you handle your
> >> >>>> pxa-linux-2.6.git tree. When and how does patches flow from
> >> >>>> your tree to mainline?
> >> >>>> 
> >> >>>> The reason I ask is that I may have some more PXA patches to post,
> >> >>>> but I don't know what tree to base it on. I'd like to use your
> >> >>>> tree, as it has improvements for colibri-pxa300, but it's
> >> >>>> difficult when you regularly(?) rebase your tree. Comments?
> >> >>> 
> >> >>> I'm basically doing rebase every -rc cycle against Linus' tree
> >> >>> instead of against Russell's, and he prefers this. Considering the
> >> >>> changes during -rc phase are normally fixing patches,
> >> >>> merge/cherry-pick/rebase are all comparatively easy. I personally
> >> >>> prefer rebase more than merge because it gives cleaner history.
> >> >> 
> >> >> Thanks for clearing that up. Now I know how you get stuff into your
> >> >> tree. But how and when do stuff get from your tree to Linus' tree?
> >> >> (I see some of the newly rebased patches in your tree are from
> >> >> august...? Shouldn't it have been in mainline by now?)
> >> > 
> >> > Will go via Russell's tree.
> >> 
> >> Ok. Thanks for explaining.
> > 
> > Hi,
> > 
> > just curious, this should make the TOP usb port or the BOTTOM one
> > working?
> 
> TOP port.

Maybe it really cannot be used with pxa310 colibri. But then I think it worked 
on their wince crap.

btw. please keep the LAKML CCed.
> 
> > I got the TOP one operational, but no luck with the bottom one on pxa310
> > colibri. Checking the colibri datasheet, there's an SMSC USB3329 chip
> > attached to usb port3 ... well did you have any luck getting the BOTTOM
> > port working ? Maybe with some further patching?
> 
> No luck with bottom port for me. Do you have a link to that datasheet?

Quick google shows some 10-page thing ... that's it.

> 
> Best regards,
> Bj?rn Forsman
