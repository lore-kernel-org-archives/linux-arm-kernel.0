From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 Jan 2010 17:44:50 +0000
Subject: flush_dcache_page does too much?
In-Reply-To: <20100119130547.GA6285@desktop>
References: <20100118131346.GA11589@desktop>
	<20100118133304.GA29645@n2100.arm.linux.org.uk>
	<20100118135431.GA12496@desktop>
	<20100118140005.GD2695@n2100.arm.linux.org.uk>
	<20100118141530.GA13394@desktop>
	<20100118144418.GE2695@n2100.arm.linux.org.uk>
	<20100118145731.GA14523@desktop>
	<20100118150152.GF2695@n2100.arm.linux.org.uk>
	<20100119001636.GA4401@desktop> <20100119130547.GA6285@desktop>
Message-ID: <20100119174450.GB1886@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 19, 2010 at 09:05:47PM +0800, anfei wrote:
> Do you think this is a bug and I can send the patch, or it's the problem
> of the test case?

Yes, it's a bug, but it needs to be reported elsewhere; neither this
list nor I can sanction patches to generic code.

It needs to be reported to the linux-kernel and linux-mm mailing lists.
