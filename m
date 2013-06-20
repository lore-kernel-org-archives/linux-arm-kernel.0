From: broonie@kernel.org (Mark Brown)
Date: Thu, 20 Jun 2013 11:35:32 +0100
Subject: [RFC PATCH 00/11] ARM: s3c64xx: Let amba-pl08x driver handle DMA
In-Reply-To: <001201ce6d98$03d9b920$0b8d2b60$%carmody@partner.samsung.com>
References: <1371416058-22047-1-git-send-email-tomasz.figa@gmail.com>
 <20130619174047.GB1403@sirena.org.uk> <3697657.tZFV7pR81Q@flatron>
 <20130619192211.GH1403@sirena.org.uk>
 <001201ce6d98$03d9b920$0b8d2b60$%carmody@partner.samsung.com>
Message-ID: <20130620103532.GA27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 12:24:47PM +0300, Phil Carmody wrote:

> Can you just make that minimal change, and diff the objdump of the two .o's?
> It would be worth a bug-report against the toolchain if different code was
> being generated. If objdump spews huge numbers of diffs (due to one address
> changing and pushing everything else out of kilter), then feel free to
> forward both .o's or both objdumps to me, and I can run a script over them,
> which knows to ignore unimportant address changes. 

See Arnd's followup - this looks like a collision with the get_signal
macro in signal.h.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130620/464c64f2/attachment.sig>
