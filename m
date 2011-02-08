From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Tue, 08 Feb 2011 16:29:52 +0100
Subject: [PATCH 2/2] ARM: iMX5 BBG: add cpuidle driver parameters
In-Reply-To: <1297178084-28363-3-git-send-email-yong.shen@linaro.org> (yong
	shen's message of "Tue, 8 Feb 2011 16:14:44 +0100")
References: <1297178084-28363-1-git-send-email-yong.shen@linaro.org>
	<1297178084-28363-3-git-send-email-yong.shen@linaro.org>
Message-ID: <87pqr2v91r.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

yong.shen at linaro.org writes:

Hi,

> From: Yong Shen <yong.shen@freescale.com>
>
> Add cpuidle parameters to make cpuidle driver workable, but these
> parameters need further tuning
>
> Signed-off-by: Yong Shen <yong.shen@freescale.com>
> ---
>  arch/arm/mach-mx5/board-mx51_babbage.c |  114 ++++++++++++++++++++++++++++++++
>  arch/arm/mach-mx5/devices.c            |    4 +
>  arch/arm/mach-mx5/devices.h            |    1 +
>  3 files changed, 119 insertions(+), 0 deletions(-)

I didn't look at how it's working nor did a review but from a very quick
look, I'm wondering why it's in board-mx51_babbage.c. Can you explain to
me what makes this code specific to babbage ?

Arnaud
