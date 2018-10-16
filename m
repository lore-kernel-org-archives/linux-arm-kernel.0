From: palmer@sifive.com (Palmer Dabbelt)
Date: Mon, 15 Oct 2018 17:04:15 -0700 (PDT)
Subject: [PATCH v2 0/6] sparsemem support for RISC-V
In-Reply-To: <20181015175702.9036-1-logang@deltatee.com>
Message-ID: <mhng-fd0541de-3ac1-4772-916d-be6b2d02e63e@palmer-si-x1c4>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 15 Oct 2018 10:56:56 PDT (-0700), logang at deltatee.com wrote:
> This patchset implements sparsemem on RISC-V. The first few patches
> move some code in existing architectures into common helpers
> so they can be used by the new RISC-V implementation. The final
> patch actually adds sparsmem support to RISC-V.
>
> This is the first small step in supporting P2P on RISC-V.

Thanks.  I see less maintainer tags for the parts that touch other ports than I 
would feel comfortable merging.  I'm going to let this sit in my inbox for 
a bit and we'll see if anything collects.

For patch sets I submit that clean up other ports I've attempted to split the 
patch into N patch sets, where:

* One part adds the generic support, which starts out as dead code.
* One part per arch uses the generic support.

This is a bit of a headache, but it at least allows us to get the RISC-V 
version that uses the generic support in quickly while waiting on acks from the 
other arch maintainers.

Like I said, I'll wait a bit and hope people ack.

Thanks!
