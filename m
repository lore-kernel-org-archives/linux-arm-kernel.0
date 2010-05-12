From: rshitrit@marvell.com (Ronen Shitrit)
Date: Wed, 12 May 2010 23:19:08 +0300
Subject: [PATCH 2/8] ARM: Implement read/write for ownership in the
	ARMv6 DMA cache ops
In-Reply-To: <20100512200434.GE22371@n2100.arm.linux.org.uk>
References: <20100504163823.26355.58568.stgit@e102109-lin.cambridge.arm.com>
	<20100504164426.26355.19161.stgit@e102109-lin.cambridge.arm.com>
	<309002C0DA137042828828FC53D7A93492FA312B64@IL-MB01.marvell.com>
	<1273672539.23818.96.camel@e102109-lin.cambridge.arm.com>
	<20100512184852.GC22371@n2100.arm.linux.org.uk>
	<20100512185903.GD22371@n2100.arm.linux.org.uk>
	<F6216D87-F137-4071-B593-AC561876D083@marvell.com>
	<20100512200434.GE22371@n2100.arm.linux.org.uk>
Message-ID: <75A52304-B6ED-45F1-9A0C-43A5135D70EA@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's assume no FIQs...

Sent from my phone

On 12/05/2010, at 23:04, "Russell King - ARM Linux" <linux at arm.linux.org.uk<mailto:linux@arm.linux.org.uk>> wrote:

On Wed, May 12, 2010 at 11:00:42PM +0300, Ronen Shitrit wrote:
This is a good point, assuming the patch will lock the int a round the
dma cache calls, can you think of any data coruption issues?

FIQs?
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100512/3b64fe4e/attachment-0001.htm>
