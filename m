From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 13 Jan 2014 19:39:25 -0500
Subject: [PATCH] ARM: Kirkwood: Add DT description of QNAP 419
In-Reply-To: <1389174517.12612.87.camel@kazak.uk.xensource.com>
References: <1389048557-16364-1-git-send-email-andrew@lunn.ch>
 <1389174517.12612.87.camel@kazak.uk.xensource.com>
Message-ID: <20140114003925.GH19878@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ian,

On Wed, Jan 08, 2014 at 09:48:37AM +0000, Ian Campbell wrote:
> What is the plan for the board files for the ts* platforms? Are they
> going to go away? This seems to have happened for the Sheevaplug case,
> which is causing some transition pain for distros (e.g.
> http://bugs.debian.org/731345).

Sorry, I'm rather swamped at the moment.  From my cursory reading of the
thread, is it correct to say that this problem can be solved by enabling
the CONFIG_MACH_SHEEVAPLUG_DT config option?

thx,

Jason.
