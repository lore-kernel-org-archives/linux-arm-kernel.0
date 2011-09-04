From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 4 Sep 2011 11:12:50 +0100
Subject: [PATCH 00/11] Add L2 cache cleaning to generic CPU suspend
In-Reply-To: <4E625796.1020109@ti.com>
References: <20110901124752.GE29729@n2100.arm.linux.org.uk>
	<4E625796.1020109@ti.com>
Message-ID: <20110904101250.GB6918@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 03, 2011 at 10:06:38PM +0530, Santosh wrote:
> Thanks a lot Russell for this series. I have tested the entire series
> with OMAP4 S2R and CPUIDLE and it works great.
>
> Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Thanks.  I've merged added that to the non-fixes stuff (which Linus
hasn't pulled) and the series into the for-next branch.
