From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 10 Sep 2014 15:58:18 +0100
Subject: [PATCH 2/2] ARM: vexpress: Remove non-DT code
In-Reply-To: <1410359618-3441-2-git-send-email-pawel.moll@arm.com>
References: <1410359618-3441-1-git-send-email-pawel.moll@arm.com>
 <1410359618-3441-2-git-send-email-pawel.moll@arm.com>
Message-ID: <20140910145818.GG12361@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 10, 2014 at 03:33:38PM +0100, Pawel Moll wrote:
> Now, with the CLCD DT support available, there is no
> more reason to keep the non-DT support for V2P-CA9.
> 
> Removed, together with "some" supporting code. It was
> necessary to make PLAT_VERSATILE_SCHED_CLOCK optional
> and selected by the machines still interested in it.

So, I'll then be asking ARM to provide updated instructions on how to
boot the CT9x4 with DT... or I'll simply take it out of the nightly
build and boot system when this patch hits mainline and stop all
testing of it.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
