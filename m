From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Tue, 08 Feb 2011 18:24:57 +0100
Subject: [PATCH 2/2] ARM: iMX5 BBG: add cpuidle driver parameters
In-Reply-To: <20110208171635.GA12943@matterhorn.lan> (Amit Kucheria's message
	of "Tue, 8 Feb 2011 19:16:35 +0200")
References: <1297178084-28363-1-git-send-email-yong.shen@linaro.org>
	<1297178084-28363-3-git-send-email-yong.shen@linaro.org>
	<87pqr2v91r.fsf@lechat.rtp-net.org>
	<AANLkTiko-OjXp2SER0=fh0acSXwYDEav=kQE94UB4zY9@mail.gmail.com>
	<20110208171635.GA12943@matterhorn.lan>
Message-ID: <87hbcev3py.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Amit Kucheria <amit.kucheria@linaro.org> writes:

> On 11 Feb 08, Yong Shen wrote:
>> Hi Arnaud,
>> 
>> I also took a while to think about this before posting patches. I prefer to
>> put it in board related code since the various PMIC used on each boards may
>> have influence on cpuidle latency or other charactors, although it could be
>> minor.
>> 
>
> Then those minor differences can be addressed in the common driver by using #ifdef
> conditionals.
>
> The cpuidle driver certainly shouldn't be board-specific.

agreed, except on #ifdef. One should be able to build one kernel for
several imx51 boards and #ifdef will probably prevent that.

Arnaud
