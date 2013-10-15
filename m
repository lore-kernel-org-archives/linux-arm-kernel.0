From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 15 Oct 2013 12:40:35 +0100
Subject: [PATCH 0/2] Revert support for reserved memory regions defined in
 device tree
In-Reply-To: <1381476448-14548-1-git-send-email-m.szyprowski@samsung.com>
References: <1381476448-14548-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20131015114035.6CA5FC40098@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Oct 2013 09:27:26 +0200, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> Hi all!
> 
> Benjamin Herrenschmidt pointed a few issues in the proposed design of
> device tree bindings for contiguous memory allocator and reserved memory
> regions:
> https://lkml.org/lkml/2013/9/15/151
> http://www.spinics.net/lists/arm-kernel/msg273548.html
> 
> Some time has passed, but there is still no consensus on the bindings
> for the reserved memory and various drawback of this solution has been
> shown, so in my opinion the best I can do now is to revert them
> completely and start from scratch again later.

I had some fixup patches that I was getting ready to post, but your
right. We're really late to be doing anything like that. I've applied
the reverts and we'll plan on hammering something out in Edinburgh next
week so that it can be merged for v3.13

g.
