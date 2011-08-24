From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Wed, 24 Aug 2011 15:21:59 +0200
Subject: [PATCH] ARM: i.MX: initialize l2x0 at early_init time
In-Reply-To: <1314189941-16406-1-git-send-email-jason.hui@linaro.org> (Jason
	Liu's message of "Wed, 24 Aug 2011 20:45:41 +0800")
References: <1314189941-16406-1-git-send-email-jason.hui@linaro.org>
Message-ID: <87y5yj9c7c.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason Liu <jason.hui@linaro.org> writes:

> This can make the l2 cache work at early time which
> will benefit the boot up time.
>
> Tested on i.mx31pdk board, test result shows:
> Before:
> [    0.555716] console [ttymxc0] enabled
>
> After:
> [    0.558755] console [ttymxc0] enabled

0.555716-0.558755 is negative, so it's slower with the patch ?

Sorry :)

Arnaud
