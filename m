From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 4 Sep 2011 11:08:42 +0100
Subject: [PATCH 08/11] ARM: pm: no need to save/restore context ID register
In-Reply-To: <4E6256BC.3080604@ti.com>
References: <20110901124752.GE29729@n2100.arm.linux.org.uk>
	<E1Qz6jT-00078d-LC@rmk-PC.arm.linux.org.uk>
	<4E6256BC.3080604@ti.com>
Message-ID: <20110904100842.GA6918@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 03, 2011 at 10:03:00PM +0530, Santosh wrote:
> Typo which results in build error.
> Error: co-processor register expected -- `mcr p15,0,ip,c13,0,1'
>
> You can fold below fix.

Kevin already reported this, and I've already folded this fix in.  Thanks.
