From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Aug 2014 23:34:41 +0100
Subject: [BUG] nfs3_list_one_acl oops
In-Reply-To: <CAHQdGtQhEQiuObg48JrNbK5L6=r0mxfSvErVC0JS4TqxxbJy_w@mail.gmail.com>
References: <20140726162143.GB20396@n2100.arm.linux.org.uk>
 <20140727131949.GB32153@infradead.org>
 <CAHQdGtQhEQiuObg48JrNbK5L6=r0mxfSvErVC0JS4TqxxbJy_w@mail.gmail.com>
Message-ID: <20140806223441.GU30282@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 27, 2014 at 11:15:40AM -0400, Trond Myklebust wrote:
> On Sun, Jul 27, 2014 at 9:19 AM, Christoph Hellwig <hch@infradead.org> wrote:
> > Thanks Russell, the patch looks good.
> 
> No. It needs to use an IS_ERR_OR_NULL() test at least in order to work
> correctly.

What's happening on this?  Did this get fixed for v3.16?

My patch still seems to apply to v3.16 so I guess NFS is broken there...

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
