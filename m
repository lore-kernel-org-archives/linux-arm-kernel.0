From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Apr 2015 17:39:56 +0100
Subject: [PATCH v1] ata: ahci_xgene: Add AHCI Support for second
 generation of APM X-Gene SoC
In-Reply-To: <20150401163116.GT9974@htj.duckdns.org>
References: <1427899682-10912-1-git-send-email-stripathi@apm.com>
 <1427899682-10912-2-git-send-email-stripathi@apm.com>
 <20150401161336.GS9974@htj.duckdns.org>
 <20150401163116.GT9974@htj.duckdns.org>
Message-ID: <20150401163956.GE24899@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 01, 2015 at 12:31:16PM -0400, Tejun Heo wrote:
> On Wed, Apr 01, 2015 at 12:13:36PM -0400, Tejun Heo wrote:
> > > Signed-off-by : Suman Tripathi <stripathi@apm.com>
> > 
> > Applied to libata/for-4.1 w/ minor edit.
> 
> Reverted due to build failure from missing asm/cputype.h.

I'm guessing this is some kind of ARM driver, which is why
linux-arm-kernel has been Cc'd - though I haven't seen the original
patch.

ARM has asm/cputype.h, and has had for a long time, so "missing
asm/cputype.h" doesn't make sense as a reason to revert it.  Maybe
it's trying to be built on x86 when it should be restricted to
only ARM?

Dunno without seeing the original patch.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
