From: yong.shen@linaro.org (Yong Shen)
Date: Tue, 8 Feb 2011 16:51:38 +0100
Subject: [PATCH 2/2] ARM: iMX5 BBG: add cpuidle driver parameters
In-Reply-To: <87pqr2v91r.fsf@lechat.rtp-net.org>
References: <1297178084-28363-1-git-send-email-yong.shen@linaro.org>
	<1297178084-28363-3-git-send-email-yong.shen@linaro.org>
	<87pqr2v91r.fsf@lechat.rtp-net.org>
Message-ID: <AANLkTiko-OjXp2SER0=fh0acSXwYDEav=kQE94UB4zY9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud,

I also took a while to think about this before posting patches. I prefer to
put it in board related code since the various PMIC used on each boards may
have influence on cpuidle latency or other charactors, although it could be
minor.

Yong

On Tue, Feb 8, 2011 at 4:29 PM, Arnaud Patard <arnaud.patard@rtp-net.org>wrote:

> yong.shen at linaro.org writes:
>
> Hi,
>
> > From: Yong Shen <yong.shen@freescale.com>
> >
> > Add cpuidle parameters to make cpuidle driver workable, but these
> > parameters need further tuning
> >
> > Signed-off-by: Yong Shen <yong.shen@freescale.com>
> > ---
> >  arch/arm/mach-mx5/board-mx51_babbage.c |  114
> ++++++++++++++++++++++++++++++++
> >  arch/arm/mach-mx5/devices.c            |    4 +
> >  arch/arm/mach-mx5/devices.h            |    1 +
> >  3 files changed, 119 insertions(+), 0 deletions(-)
>
> I didn't look at how it's working nor did a review but from a very quick
> look, I'm wondering why it's in board-mx51_babbage.c. Can you explain to
> me what makes this code specific to babbage ?
>
> Arnaud
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110208/a7913e49/attachment-0001.html>
