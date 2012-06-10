From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 10 Jun 2012 19:22:22 -0400
Subject: [PATCH 9/9] Kirkwood: Add basic device tree support for QNAP
 TS219.
In-Reply-To: <20120610174842.GA22507@lunn.ch>
References: <1339324322-29388-10-git-send-email-andrew@lunn.ch>
 <20120610172313.GA14756@titan.lakedaemon.net>
 <20120610174842.GA22507@lunn.ch>
Message-ID: <20120610232222.GC14756@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 10, 2012 at 07:48:42PM +0200, Andrew Lunn wrote:
> It would be good if all the DT boards where compiled all the time.  We
> can then see build failures in kisskb.

Yep, I've included this, as well as watchdog and a few others.  The
series will also include the s/mrvl/marvell/g conversion, and the
CONFIG_ARM_PATCH_PHYS_VIRT correct answer.  Which I'm still working on.

thx,

Jason.
