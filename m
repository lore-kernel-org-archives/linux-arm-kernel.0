From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 Nov 2009 23:19:20 +0000
Subject: [PATCH 1/1] Remove suspend/resume functionality, add dynamic
	clocking
In-Reply-To: <083DF309106F364B939360100EC290F804F55C9225@eu1rdcrdc1wx030.exi.nxp.com>
References: <083DF309106F364B939360100EC290F804F55C9225@eu1rdcrdc1wx030.exi.nxp.com>
Message-ID: <20091130231920.GB10705@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2009 at 10:23:21PM +0100, Kevin Wells wrote:
> Remove suspend/resume functionality, I2C driver gates clock on
> only when an I2C transaction is in progress

Well, I'm happy with this (we have other drivers which don't do anything
spectacular in their suspend handling as well.)

Can you submit it to the patch system please?
