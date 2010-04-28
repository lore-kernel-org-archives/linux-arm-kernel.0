From: jassisinghbrar@gmail.com (jassi brar)
Date: Wed, 28 Apr 2010 10:19:39 +0900
Subject: [PATCH 01/01] ARM: S3C2412: DMA: Remove I2S FIFO address
In-Reply-To: <20100428000652.GC24020@trinity.fluff.org>
References: <1272351118-29175-1-git-send-email-jassi.brar@samsung.com>
	<20100428000652.GC24020@trinity.fluff.org>
Message-ID: <g2n1b68c6791004271819re7f7f625s2749c81b3f76b60@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 28, 2010 at 9:06 AM, Ben Dooks <ben-linux@fluff.org> wrote:
> On Tue, Apr 27, 2010 at 03:51:58PM +0900, JassiBrar wrote:
>> From: Jassi Brar <jassi.brar@samsung.com>
>>
>> The S3C DMA API doesn't make use of hw_addr.to/from and also
>> the FIFO addresses are provided from the I2S drivers. So these
>> fields are redundant.
>> This patch removes the hw_addr.to/from fields for I2S and the
>> inclusion of header, paving way for the header to be moved closer
>> to the I2S controller drivers.
>
> Ok, if this works for -rc series then it may be something that could
> be merged before we get to the next merge window.
I believe this has never had any effect and can be safely merged.
Just try a quick
    grep hw_addr -r arch/arm/*
