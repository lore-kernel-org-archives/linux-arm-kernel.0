From: hch@lst.de (Christoph Hellwig)
Date: Thu, 7 Aug 2014 09:12:24 +0200
Subject: [BUG] nfs3_list_one_acl oops
In-Reply-To: <20140806223441.GU30282@n2100.arm.linux.org.uk>
References: <20140726162143.GB20396@n2100.arm.linux.org.uk>
 <20140727131949.GB32153@infradead.org>
 <CAHQdGtQhEQiuObg48JrNbK5L6=r0mxfSvErVC0JS4TqxxbJy_w@mail.gmail.com>
 <20140806223441.GU30282@n2100.arm.linux.org.uk>
Message-ID: <20140807071224.GA17501@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 06, 2014 at 11:34:41PM +0100, Russell King - ARM Linux wrote:
> What's happening on this?  Did this get fixed for v3.16?

Trond has Andrey's patch queued up for 3.17 with a Cc to stable, so it
will go into a 3.16 stable kernel as soon as it hits Linus' tree.
