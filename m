From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 21 Oct 2013 08:46:12 +0800
Subject: [PATCH RFC 1/2] ARM: imx6qdl: provide pinctrl configurations for
 DAT3 pull-down
In-Reply-To: <20131019150556.GI25034@n2100.arm.linux.org.uk>
References: <20131005112147.GX12758@n2100.arm.linux.org.uk>
 <E1VSPw9-0004Ug-BF@rmk-PC.arm.linux.org.uk>
 <20131007055340.GB3739@S2101-09.ap.freescale.net>
 <20131007180357.GS12758@n2100.arm.linux.org.uk>
 <20131008015426.GA7480@S2101-09.ap.freescale.net>
 <52537378.1020904@wwwdotorg.org>
 <20131008034048.GB7480@S2101-09.ap.freescale.net>
 <20131008090015.GC25034@n2100.arm.linux.org.uk>
 <20131019150556.GI25034@n2100.arm.linux.org.uk>
Message-ID: <20131021004610.GB17165@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 19, 2013 at 04:05:56PM +0100, Russell King - ARM Linux wrote:
> I can't find what the result of this discussion was, but from what I
> remember, we decided that we weren't going to do this override thing,
> and instead we were going to separate out the configuration of DAT3.
> 
> Who's going to do that?

I'm going to do that.  Thanks for reminding :)

Shawn

> I'd rather not, because it means editing
> quite a number of DT files which I have no way to test, and the
> chances of messing this up are quite high.  I've already developed
> a deep seated hatred for DT in general through my involvement with
> IMX, particularly how it's very easy to make an undetected mistake
> and then spend hours debugging it.
> 
> Until this is resolved, I'm sticking with my own method of redefining
> the entire pinctrl set for DAT3 pull-down, which I've tested as working.
