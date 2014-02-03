From: trond.myklebust@primarydata.com (Trond Myklebust)
Date: Mon, 3 Feb 2014 15:32:39 -0500
Subject: NFS client broken in Linus' tip
In-Reply-To: <20140203202543.GA7070@infradead.org>
References: <20140130141405.GA23985@infradead.org>
 <20140130142752.GX15937@n2100.arm.linux.org.uk>
 <20140130143208.GB9573@infradead.org>
 <20140130153812.GA15937@n2100.arm.linux.org.uk>
 <1391201970.6978.1.camel@leira.trondhjem.org>
 <20140203080325.GB806@infradead.org>
 <85AAFCF5-60EE-42E5-B103-37A4613C5947@primarydata.com>
 <20140203145759.GA30263@infradead.org>
 <3003D7E5-93F8-4B32-ACDB-07ED3F6CE70D@primarydata.com>
 <1391458935.17089.1.camel@leira.trondhjem.org>
 <20140203202543.GA7070@infradead.org>
Message-ID: <93466B34-9D46-4AF2-8806-8CC5D3371F4D@primarydata.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Feb 3, 2014, at 15:25, Christoph Hellwig <hch@infradead.org> wrote:

> On Mon, Feb 03, 2014 at 03:22:15PM -0500, Trond Myklebust wrote:
>> FWIW, here is the alternative patch. I've tested it, and it seems to
>> work.
> 
> I much prefer the original one.  One major point of the series was to
> get individual filesystems out of the business of providing xattr
> handlers for ACLs.
> 

Then could you and Al please provide an Acked-by? This is a userspace API, so we shouldn?t be changing return values without good reason.

--
Trond Myklebust
Linux NFS client maintainer
