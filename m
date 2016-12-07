From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 07 Dec 2016 20:09:35 +0100
Subject: [PATCH 4/9] arm64: dts: rockchip: support dwc3 USB for rk3399
In-Reply-To: <20161207190301.GA107036@google.com>
References: <1480645653-36943-1-git-send-email-briannorris@chromium.org>
 <1972184.o3UeJg0tK9@phil> <20161207190301.GA107036@google.com>
Message-ID: <5292364.Xa7yl762Dv@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 7. Dezember 2016, 11:03:02 CET schrieb Brian Norris:
> On Wed, Dec 07, 2016 at 08:01:23PM +0100, Heiko Stuebner wrote:
> > Am Mittwoch, 7. Dezember 2016, 09:52:08 CET schrieb Brian Norris:
> > > But pcie at f8000000 is also out of order then. I guess maybe
> > > that's the only one then.
> > 
> > Yep, pcie is misplaced as sadly sometimes I miss those errors as well.
> 
> OK. Do you want me to patch that at the end of my series, or is that
> unnecessary churn?

I'm still pondering [and am investing way to much brain cells in trying to 
decide this ;-) ], but tend to want to move it.

That way the dtsi gives the correct sorting impression for future dt-patches 
of which I guess we'll see a lot in the time to come.

So yes, please move it as well.


Thanks
Heiko
