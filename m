From: hch@lst.de (Christoph Hellwig)
Date: Sun, 18 Dec 2016 10:23:29 +0100
Subject: [PATCH 3/3] mm: make pagoff_t type 64-bit
In-Reply-To: <20161216105514.GA466@yury-N73SV>
References: <1481461003-14361-1-git-send-email-ynorov@caviumnetworks.com>
 <1481461003-14361-4-git-send-email-ynorov@caviumnetworks.com>
 <2636242.RWRJivuddj@wuerfel> <20161216105514.GA466@yury-N73SV>
Message-ID: <20161218092329.GA16618@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 16, 2016 at 04:25:14PM +0530, Yury Norov wrote:
>  1 leave things as is. 32-bit architectures will have no option to
>    mmap big offsets, and no one cares - as usual.

And that's the only sensible option.
