From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 27 Nov 2014 09:52:55 +0100
Subject: [PATCH] clk: rockchip: rk3288 export i2s0_clkout for use in DT
In-Reply-To: <CAPz6YkXOS08hv7x+DM3roTuZYMbh9n4=kpTrH8NGYUffczQwLA@mail.gmail.com>
References: <1416381319-31117-1-git-send-email-sonnyrao@chromium.org>
 <3863623.tcGxuFQcZa@diego>
 <CAPz6YkXOS08hv7x+DM3roTuZYMbh9n4=kpTrH8NGYUffczQwLA@mail.gmail.com>
Message-ID: <56685599.NrGFKacCZ1@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 26. November 2014, 19:47:10 schrieb Sonny Rao:
> On Wed, Nov 26, 2014 at 3:32 PM, Heiko St?bner <heiko@sntech.de> wrote:
> > Am Dienstag, 18. November 2014, 23:15:19 schrieb Sonny Rao:
> >> This exposes the clock that comes out of the i2s block which generally
> >> goes to the audio codec.
> >> 
> >> Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
> > 
> > applied to my clk branch after removing the CLK_SET_RATE_PARENT
> 
> Hi, sorry for the delay, and thanks for fixing it.  I think when I
> applied the patch to next-20141118 that had a CLK_SET_RATE_PARENT in
> it from this patch:
> 
> commit fc69ed70c16a31d6a77ec47a30a9fe941f763f1e
> Author: Jianqun <jay.xu@rock-chips.com>
> Date:   Tue Sep 30 11:12:04 2014 +0800
> 
>     clk: rockchip: rk3288: i2s_frac adds flag to set parent's rate
> 
> 
> I agree that is is not necessary and maybe not desirable.  Thanks again!

glad to be of help :-)

Just for reference, the commit removing this CLK_SET_RATE_PARENT is [0] that 
incidentally got pulled in by Mike on the same 20141118 and was therefore part 
of linux-next 20141119



[0] https://git.kernel.org/cgit/linux/kernel/git/mmind/linux-rockchip.git/commit/?id=8f06f5d392b3fbd58a5d7e00b047b6ee08c6d9b0
