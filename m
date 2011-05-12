From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 May 2011 23:01:29 +0100
Subject: [PATCH] ARM: Do not use__init annotations to declarations
In-Reply-To: <4DC597E4.2030003@freescale.com>
References: <1302388820-18783-1-git-send-email-festevam@gmail.com>
	<4DC597E4.2030003@freescale.com>
Message-ID: <20110512220129.GE6098@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 07, 2011 at 04:05:08PM -0300, Fabio Estevam wrote:
> Is this patch OK?

Patch is fine as far as it goes.  However, with the current focus on
the amount of churn in the ARM tree, I'm debating whether or not to
take this, or wait until these files get touched by some other patch
first.
