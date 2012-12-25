From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 25 Dec 2012 22:10:23 +0800
Subject: [PATCH 1/2] mxs timer: use ahbx bus clock to drive the timers on
 timrotv2
In-Reply-To: <1356098776-10498-2-git-send-email-torbenh@linutronix.de>
References: <1356098776-10498-1-git-send-email-torbenh@linutronix.de>
 <1356098776-10498-2-git-send-email-torbenh@linutronix.de>
Message-ID: <20121225141020.GB25478@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 21, 2012 at 03:06:15PM +0100, Torben Hohn wrote:
> timer resolution of ~32us is pretty low.
> v2 has 32bits resolution, so we have quite some headroom, and
> can use the 24MHz clock.
> v1 has only 16bits, so we only increase v2.
> 
> So we just exchange the timrot clock in imx28.
> On imx23 we have timrotv1 and everything stays the same.
> 
> Signed-off-by: Torben Hohn <torbenh@linutronix.de>

1) s/ahbx/apbx on patch subject.
2) The patch prefix should look like "ARM: mxs: ..."

Fixed them and applied both patches.  Thanks.

Shawn
