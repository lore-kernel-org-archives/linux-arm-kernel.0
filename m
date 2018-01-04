From: hch@lst.de (Christoph Hellwig)
Date: Thu, 4 Jan 2018 09:48:28 +0100
Subject: [PATCH 16/67] powerpc: rename dma_direct_ to dma_nommu_
In-Reply-To: <CAGRGNgV+DnZAAtiE5oe8rxp4=_JHJrtSQc8F5jrgN0rgYKfwjA@mail.gmail.com>
References: <20171229081911.2802-1-hch@lst.de>
 <20171229081911.2802-17-hch@lst.de> <878tdgtwzp.fsf@concordia.ellerman.id.au>
 <CAMuHMdWWus2kNSOzS94k-3678826W1YjKwCWTquu3hBLZ80cvw@mail.gmail.com>
 <87h8s3cvel.fsf@concordia.ellerman.id.au>
 <CAMuHMdWYDz_jHNxQ-B8944520R-myzHkjkL1rKWUjA38inU7cw@mail.gmail.com>
 <CAGRGNgV+DnZAAtiE5oe8rxp4=_JHJrtSQc8F5jrgN0rgYKfwjA@mail.gmail.com>
Message-ID: <20180104084828.GA3251@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 03, 2018 at 07:19:46PM +1100, Julian Calaby wrote:
> If this is indeed a linear mapping, can we just remove this and
> replace it with the new "generic" mapping being introduced by this
> patchset?

That is the long-term plan.  But as the powerpc one includes support
for non-coherent DMA it will have to wait for the next batch.
