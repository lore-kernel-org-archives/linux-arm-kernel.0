From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 09 Sep 2014 10:09:20 +0200
Subject: [PATCH v5 3/4] ARM: dts: add rk3288 dwc2 controller support
In-Reply-To: <1596739.u7ZntKLW7r@diego>
References: <1407470159-14722-1-git-send-email-kever.yang@rock-chips.com>
 <CAD=FV=XNSp85H2zVrLPdxDfhokEWFspvwUHjVMWRu8k_wFFm0Q@mail.gmail.com>
 <1596739.u7ZntKLW7r@diego>
Message-ID: <1765958.gOlsR47vAx@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 8. August 2014, 17:53:45 schrieb Heiko St?bner:
> Am Freitag, 8. August 2014, 08:45:16 schrieb Doug Anderson:
> > Kever,
> > 
> > On Thu, Aug 7, 2014 at 8:55 PM, Kever Yang <kever.yang@rock-chips.com>
> 
> wrote:
> > > rk3288 has two kind of usb controller, this add the dwc2 controller
> > > for otg and host1.
> > > 
> > > Controller can works with usb PHY default setting and Vbus on.
> > > 
> > > Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> > > Reviewed-by: Doug Anderson <dianders@chromium.org>
> > > Tested-by: Doug Anderson <dianders@chromium.org>
> > > ---
> > > 
> > > Changes in v5:
> > > - change the sort order of dwc2 in rk3288.dtsi
> > > 
> > > Changes in v4: None
> > > Changes in v3:
> > > - EHCI and HSIC move new for version 3.
> > > 
> > > Changes in v2: None
> > > 
> > >  arch/arm/boot/dts/rk3288.dtsi | 20 ++++++++++++++++++++
> > >  1 file changed, 20 insertions(+)
> > 
> > IMHO this series is ready to go in for 3.18.  I'm assuming Heiko will
> > pick it up once the bindings have landed.  It already has my tags.  ;)
> 
> correct ... the dts changes look ok, so I'll take patches 3 and 4 once
> patches 1 and 2 are included somewhere.
> 

I've added patches 3 and 4 to my v3.18-next/dts branch
