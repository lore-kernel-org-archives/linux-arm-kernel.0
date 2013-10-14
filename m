From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 14 Oct 2013 10:27:09 -0700
Subject: Is next/cleanup of arm-soc tree stable?
In-Reply-To: <20131014161309.GG27668@S2101-09.ap.freescale.net> (Shawn Guo's
 message of "Tue, 15 Oct 2013 00:13:11 +0800")
References: <20131014161309.GG27668@S2101-09.ap.freescale.net>
Message-ID: <87mwmb930y.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo <shawn.guo@linaro.org> writes:

> Olof, Kevin,
>
> Per reports from linux-next folks, it seems that my imx/soc branch
> conflicts with Sebastian's clk-of-init-v2_for-3.13 quite badly.  I'm
> considering to rebase my imx/soc branch on arm-soc next/cleanup branch
> to solve the conflicts.  But is the branch stable, or do I have to base
> on Sebastian's clk-of-init-v2_for-3.13 branch (assume it's stable)?

Generally, the next/* branches are not stable.

It would be better if you could get a commitment from Sebastian for a
immutable branch and base directly on that.

Kevin
