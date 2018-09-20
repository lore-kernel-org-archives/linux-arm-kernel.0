From: hch@lst.de (Christoph Hellwig)
Date: Thu, 20 Sep 2018 08:29:46 +0200
Subject: clean up physical merging helpers
In-Reply-To: <b8f3621a-f789-d737-649f-7b3645912888@kernel.dk>
References: <20180904191431.20102-1-hch@lst.de> <20180915070300.GA10555@lst.de>
 <b8f3621a-f789-d737-649f-7b3645912888@kernel.dk>
Message-ID: <20180920062946.GA12893@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 15, 2018 at 08:47:13AM -0600, Jens Axboe wrote:
> >> this series moves various helpers related to merging based on physical
> >> addresses from the public headers into block/, moves the Xen special
> >> case from arch hooks into common code, cleans up the code a bit, and
> >> removes not nessecary includes from the block headers.
> > ---end quoted text---
> > 
> 
> It's a good cleanup, I like it. Would prefer if the arm/xen folks could
> ack the first bits,

Konread, can you look at the series (or delegate).

> and 13/13 should probably just to in differently.

I can't parse this setence.
