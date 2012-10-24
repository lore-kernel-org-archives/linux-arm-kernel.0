From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 24 Oct 2012 22:04:55 +0800
Subject: [PATCH 10/10] ARM: imx6q: implement WAIT mode with coupled cpuidle
In-Reply-To: <D9DA41B75289BC488A38AE7992B7866301261C4A@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1351005779-30347-1-git-send-email-shawn.guo@linaro.org>
 <1351005779-30347-11-git-send-email-shawn.guo@linaro.org>
 <D9DA41B75289BC488A38AE7992B7866301261C4A@039-SN2MPN1-022.039d.mgd.msft.net>
Message-ID: <20121024140443.GB2464@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2012 at 04:09:08PM +0000, Lee Robert-B18647 wrote:
> Hey Shawn,
> 
> For your SRPG implementation, a couple of weeks ago an issue was found that affects all i.MX6 SRPG functionality that requires a work around for 100% reliable operation.  It's my understanding that the workaround is almost but not yet finalized.  Ranjani is most familiar with this issue so you and her can discuss further.
> 
Thanks for the info, Rob.

I worked with Anson today trying to reproduce the issue with my kernel
on imx6q.  But so far, we can not reproduce it.  So I would have the
series go as it is, and we can add workaround later when we see the
real failure on imx6q to keep the history clear.

Shawn
