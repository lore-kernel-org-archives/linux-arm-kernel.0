From: broonie@kernel.org (Mark Brown)
Date: Mon, 12 Jan 2015 15:02:49 +0000
Subject: [PATCH] arm64: dump: Fix implicit inclusion of definition for
 PCI_IOBASE
In-Reply-To: <20150112134611.GF16706@leverpostej>
References: <1421065784-31708-1-git-send-email-broonie@kernel.org>
 <20150112134611.GF16706@leverpostej>
Message-ID: <20150112150249.GM4160@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 12, 2015 at 01:46:11PM +0000, Mark Rutland wrote:

> I see that for other definitions we include the asm headers rather than
> linux headers, and we also seem to be missing an include of asm/memory.h
> for MODULES_VADDR and PAGE_OFFSET.

> Does the below work for you?

Should do.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150112/955dc12d/attachment.sig>
