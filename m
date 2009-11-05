From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 5 Nov 2009 11:04:32 +0000
Subject: S3C64XX DMA driver fixes
In-Reply-To: <1257396253-32108-1-git-send-email-jassi.brar@samsung.com>
References: <1257396253-32108-1-git-send-email-jassi.brar@samsung.com>
Message-ID: <20091105110432.GC4808@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 05, 2009 at 01:44:13PM +0900, Jassi Brar wrote:
> Hello,
>   Following are a few patches against 
>  http://www.fluff.org/git/bjdooks/linux.git fixes-s3c64xx-dma
>  commit 7ec6b719e4f75f9e73b610b7a71255d639cd566b
> 
>  Among other things, the patches enable the PL-080 driver to
>  work with non-circular buffer queues as well. The implementation
>  was tested with I2S driver by making s3c_dma_has_circular() return
>  false. My not-yet-submitting SPI driver works fine too after these
>  patches.

Thanks, i'll have a look at this and see if they can be sent before the
next merge window or not.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
