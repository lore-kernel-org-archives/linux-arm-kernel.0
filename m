From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 10 May 2012 21:41:20 +0800
Subject: [PATCH V2 03/11] ASoC: imx-audmux: add pinctrl support
In-Reply-To: <CACRpkdah3956QLZZ1wTw1PcZ90wWX=Ta9j45jjzWsBtT=nm8-g@mail.gmail.com>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
 <1336563190-19974-4-git-send-email-richard.zhao@freescale.com>
 <20120509160005.GG3955@opensource.wolfsonmicro.com>
 <20120510003532.GG2982@b20223-02.ap.freescale.net>
 <20120510063904.GB17875@S2101-09.ap.freescale.net>
 <20120510084403.GA3908@opensource.wolfsonmicro.com>
 <20120510090459.GH2982@b20223-02.ap.freescale.net>
 <20120510092733.GH3908@opensource.wolfsonmicro.com>
 <20120510102309.GK2982@b20223-02.ap.freescale.net>
 <CACRpkdah3956QLZZ1wTw1PcZ90wWX=Ta9j45jjzWsBtT=nm8-g@mail.gmail.com>
Message-ID: <20120510134120.GM2982@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 02:26:31PM +0200, Linus Walleij wrote:
> On Thu, May 10, 2012 at 12:23 PM, Richard Zhao
> <richard.zhao@freescale.com> wrote:
> > On Thu, May 10, 2012 at 10:27:34AM +0100, Mark Brown wrote:
> >> On Thu, May 10, 2012 at 05:05:00PM +0800, Richard Zhao wrote:
> >>
> >> > devm_pinctrl_get_select_default function is added in below commit which
> >> > is in pinctrl/for-next.
> >>
> >> Oh, dear. ?That's unfortunate, I guess it's not on a branch in pinctl
> >> which can be pulled separately (...)
> >
> > I prefer to have a non-rebase pinctrl branch. We can not defer pinctrl
> > patch for all drivers. pinctrl will be so widely used.
> >
> > Hi Linus,
> >
> > Could you comment?
> 
> You're lucky because a few ARM SoC:s wanted a stable tag to
> use for pinctrl merges.
> 
> Ref:
> git://git.linaro.org/people/triad/linux-pinctrl.git
> 
> The tag pinctrl-mergebase-20120418
I only find the tag at your kernel.org git tree. Linaro switched git
server again? strange.

Mark,

Are you ok with that?

Thanks
Richard
> contains the devm and other changes, Stephen is already using
> that for Tegra stuff and it's solid as a rock. Newer patches are
> put on top of this and since pinctrl has no deps in any directions
> it will be requested for pull as soon as the merge window opens.
> 
> Yours,
> Linus Walleij
> 
