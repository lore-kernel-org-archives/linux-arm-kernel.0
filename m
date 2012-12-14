From: ben@decadent.org.uk (Ben Hutchings)
Date: Fri, 14 Dec 2012 14:11:59 +0000
Subject: [PATCH] mxs: uart: allow setting RTS from software
In-Reply-To: <1355329913-27666-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1355329913-27666-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <20121214141159.GM13292@decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 12, 2012 at 05:31:53PM +0100, Steffen Trumtrar wrote:
> With the patch "serial: mxs-auart: fix the wrong RTS hardware flow control" the
> mainline mxs-uart driver now sets RTSEN only when hardware flow control is
> enabled via software. It is not possible any longer to set RTS manually via
> software. However, the manual modification is a valid operation.
> Regain the possibility to set RTS via software and only set RTSEN when hardware
> flow control is explicitly enabled via settermios cflag CRTSCTS.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
[...]

This is not the correct way to submit a patch to stable.  See
Documentation/stable_kernel_rules.txt

Ben.

-- 
Ben Hutchings
We get into the habit of living before acquiring the habit of thinking.
                                                              - Albert Camus
