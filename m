From: trond.myklebust@primarydata.com (Trond Myklebust)
Date: Sun, 27 Jul 2014 11:15:40 -0400
Subject: [BUG] nfs3_list_one_acl oops
In-Reply-To: <20140727131949.GB32153@infradead.org>
References: <20140726162143.GB20396@n2100.arm.linux.org.uk>
 <20140727131949.GB32153@infradead.org>
Message-ID: <CAHQdGtQhEQiuObg48JrNbK5L6=r0mxfSvErVC0JS4TqxxbJy_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 27, 2014 at 9:19 AM, Christoph Hellwig <hch@infradead.org> wrote:
> Thanks Russell, the patch looks good.

No. It needs to use an IS_ERR_OR_NULL() test at least in order to work
correctly.

-- 
Trond Myklebust

Linux NFS client maintainer, PrimaryData

trond.myklebust at primarydata.com
