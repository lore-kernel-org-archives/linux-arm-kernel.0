From: hch@lst.de (Christoph Hellwig)
Date: Thu, 4 Jan 2018 09:45:33 +0100
Subject: [PATCH 17/67] microblaze: rename dma_direct to dma_microblaze
In-Reply-To: <CAGRGNgW1qwLcCAvU2Jc=3_7b-0Bu016to3cQUgVsc+ca0No_6g@mail.gmail.com>
References: <20171229081911.2802-1-hch@lst.de>
 <20171229081911.2802-18-hch@lst.de>
 <CAGRGNgW1qwLcCAvU2Jc=3_7b-0Bu016to3cQUgVsc+ca0No_6g@mail.gmail.com>
Message-ID: <20180104084533.GA3135@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 29, 2017 at 09:11:56PM +1100, Julian Calaby wrote:
> Hi Christoph,
> 
> On Fri, Dec 29, 2017 at 7:18 PM, Christoph Hellwig <hch@lst.de> wrote:
> > This frees the dma_direct_* namespace for a generic implementation.
> 
> Don't you mean "dma_nommu" not "dma_microblaze" in the subject line?

Yes, thanks.
