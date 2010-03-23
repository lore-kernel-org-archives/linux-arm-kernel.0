From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Mar 2010 21:38:39 +0000
Subject: [PATCH 3/5] ARM: Correct the VFPv3 detection
In-Reply-To: <20100322151950.6353.47048.stgit@e102109-lin.cambridge.arm.com>
References: <20100322151729.6353.79984.stgit@e102109-lin.cambridge.arm.com>
	<20100322151950.6353.47048.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100323213839.GJ19572@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 22, 2010 at 03:19:50PM +0000, Catalin Marinas wrote:
> A CPU has VFPv3 hardware if the FPSID[19:16] bits are 2 or more.
> Currently Linux was only checking for 3 or more.

Ok.
