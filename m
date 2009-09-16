From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 16 Sep 2009 02:01:45 +0100
Subject: S3C6410 support patches follows
In-Reply-To: <1b68c6790909150248i503b5898u7c2bcf883cb7be0@mail.gmail.com>
References: <1b68c6790909150248i503b5898u7c2bcf883cb7be0@mail.gmail.com>
Message-ID: <20090916010145.GI24720@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2009 at 06:48:23PM +0900, jassi brar wrote:
> Hello,
>   I am going to submit patches towards enabling S3C6410 I2S audio support.
> 
> In the process i came across some bugs and some options that needs to
> be implemented.
> I include such changes as patches for S3C64XX DMA and I2S CPU driver.
> Tomorrow i will submit the machine driver.

Your commits are getting the fullname truncated, as shown by the
shortlog output of next-s3c64xx-fixes:

Jassi (3):
      ARM: S3C64XX: DMA: struct s3c64xx_dma_buff lli fix.
      ARM: S3C64XX: DMA: 'size' argument of dma_pool_create
      ARM: S3C64XX: DMA: Debugged alloc's with GFP_KERNEL flag in Intr context.
 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
