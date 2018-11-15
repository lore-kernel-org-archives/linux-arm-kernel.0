From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 15 Nov 2018 12:58:04 -0800
Subject: move the arm arch_dma_alloc implementation to common code
In-Reply-To: <20181115195041.GC4535@brain-police>
References: <20181105121931.13481-1-hch@lst.de>
 <20181109075238.GA27578@lst.de> <20181115195041.GC4535@brain-police>
Message-ID: <b3267453-0c2d-4bda-2122-d6212967dafc@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-11-15 11:50 am, Will Deacon wrote:
> On Fri, Nov 09, 2018 at 08:52:38AM +0100, Christoph Hellwig wrote:
>> Can I get a quick review from the arm64 folks?  I think it should
>> be fine there as it basically is a code move, but an additional pair
>> or two of eyes always helps to weed out bugs.
> 
> I reviewed the arm64 parts, but it would be ideal if Robin could have a look
> as well.

Yup, from a quick skim the general shape of the whole series looks 
pleasing, but I've been holding off going through it in detail until 
I've figured out what's up with the last thing I thought I'd reviewed 
exhaustively...

Either way I'll make some time for a proper look next week once I'm back.

Robin.
