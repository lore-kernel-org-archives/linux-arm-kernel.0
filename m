From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 12 Feb 2011 14:50:10 +0000
Subject: [PATCH v3 2/5] ARM: pm: add generic CPU suspend/resume support
In-Reply-To: <998315b4ab88b66cc0e32e73d10a0015@mail.gmail.com>
References: <E1PmA28-0000AC-2t@rmk-PC.arm.linux.org.uk>
	<20110207120103.GC31929@n2100.arm.linux.org.uk>
	<20110207121052.GD31929@n2100.arm.linux.org.uk>
	<AANLkTintBD2Gfb3pkPZPe2mreU5EatUnNwUqR-id7q+M@mail.gmail.com>
	<20110207133457.GE31929@n2100.arm.linux.org.uk>
	<AANLkTi=B45PuOErxR49Gfhfq6-=y_NugbWBLBo0MEoCt@mail.gmail.com>
	<20110207141734.GG31929@n2100.arm.linux.org.uk>
	<AANLkTimCtaSZ=CHT5snWZ496_bi4sH=0LU7vJ-Jfh=dP@mail.gmail.com>
	<20110211115853.GC23404@n2100.arm.linux.org.uk>
	<998315b4ab88b66cc0e32e73d10a0015@mail.gmail.com>
Message-ID: <20110212145010.GK15616@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 11, 2011 at 05:37:04PM +0530, Santosh Shilimkar wrote:
> There is a Monitor secure API, needs to be called from non-secure
> software to set this diagnostic registers in resume path.

It would be an idea to get the OMAP sleep code up to date so that I can
look at OMAPs requirements for this to be useful.

As the current code stands, I don't see any reason why the sleep34xx code
can't use this infrastructure, but I'm loathed to start modifying that if
there's outstanding code changes in that area.
