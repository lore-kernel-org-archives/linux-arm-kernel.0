From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Tue, 8 Feb 2011 19:40:51 +0200
Subject: [PATCH 2/2] ARM: iMX5 BBG: add cpuidle driver parameters
In-Reply-To: <87hbcev3py.fsf@lechat.rtp-net.org>
References: <1297178084-28363-1-git-send-email-yong.shen@linaro.org>
	<1297178084-28363-3-git-send-email-yong.shen@linaro.org>
	<87pqr2v91r.fsf@lechat.rtp-net.org>
	<AANLkTiko-OjXp2SER0=fh0acSXwYDEav=kQE94UB4zY9@mail.gmail.com>
	<20110208171635.GA12943@matterhorn.lan>
	<87hbcev3py.fsf@lechat.rtp-net.org>
Message-ID: <20110208174051.GC12943@matterhorn.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 Feb 08, Arnaud Patard wrote:
> Amit Kucheria <amit.kucheria@linaro.org> writes:
> 
> > On 11 Feb 08, Yong Shen wrote:
> >> Hi Arnaud,
> >> 
> >> I also took a while to think about this before posting patches. I prefer to
> >> put it in board related code since the various PMIC used on each boards may
> >> have influence on cpuidle latency or other charactors, although it could be
> >> minor.
> >> 
> >
> > Then those minor differences can be addressed in the common driver by using #ifdef
> > conditionals.
> >
> > The cpuidle driver certainly shouldn't be board-specific.
> 
> agreed, except on #ifdef. One should be able to build one kernel for
> several imx51 boards and #ifdef will probably prevent that.

You're right. I should've said runtime detection.
