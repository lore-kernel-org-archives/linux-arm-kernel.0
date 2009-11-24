From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Nov 2009 17:02:35 +0000
Subject: [PATCH v2 06/17] ARM: dma-mapping: fix for speculative accesses
In-Reply-To: <c70ff3ad0911240840q5fd1d10cx730df18216c18bf@mail.gmail.com>
References: <E1NBYEF-0005l7-Tq@rmk-PC.arm.linux.org.uk>
	<E1NCZ7p-0002A0-Ib@rmk-PC.arm.linux.org.uk>
	<c70ff3ad0911230725h6d688c09k8576b66d012f29f0@mail.gmail.com>
	<20091123172722.GE18142@n2100.arm.linux.org.uk>
	<c70ff3ad0911240746v3438bba9y556cca3f027b3dd7@mail.gmail.com>
	<20091124162250.GA17481@n2100.arm.linux.org.uk>
	<c70ff3ad0911240840q5fd1d10cx730df18216c18bf@mail.gmail.com>
Message-ID: <20091124170235.GC17481@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2009 at 06:40:39PM +0200, saeed bishara wrote:
> this patch series fixes the cache coherency due to the speculative
> prefetch issue . but what about the case were the cpu prefetches
> address from I/O registers (when the cpu the manager mode)?

That's an entirely separate issue which has nothing to do with DMA mapping.

At this point, I'm sitting on soo many patches that I really don't want to
tackle any more ARMv7 issues for the upcoming merge window - certainly not
until we get some of these patches finalized and merged into my 'devel'
branch.

Any of these series which aren't merged into my 'devel' branch within the
next 24 hours will not be going in the next merge window.

If there is a -rc9, it should be on Thursday, and then there will be
about one week before the merge window opens.  If there isn't going to
be a -rc9, the merge window should open on Thursday.

It is bad form to suddenly spring a load of patches into linux-next at
short notice.
