From: broonie@sirena.org.uk (Mark Brown)
Date: Wed, 28 Oct 2009 12:39:45 +0000
Subject: [PATCH 08/12] ARM: S3C: Add info for supporting circular DMA
	buffers
In-Reply-To: <1256732153-22027-8-git-send-email-ben-linux@fluff.org>
References: <1256732153-22027-1-git-send-email-ben-linux@fluff.org>
	<1256732153-22027-8-git-send-email-ben-linux@fluff.org>
Message-ID: <20091028123944.GB23925@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 28, 2009 at 12:15:49PM +0000, Ben Dooks wrote:
> The S3C64XX DMA implementation will work a lot better with the ability
> to enqueue circular buffers as the hardware can do it's own linked-list
> management.

> Add a function s3c_dma_has_circular() to show that the system can do this
> and a flag for the channel.

> Update the s3c24xx/s3c64xx I2S DMA code to deal with this.

> Signed-off-by: Ben Dooks <ben@simtec.co.uk>
> Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> CC: Mark Brown <broonie@@opensource.wolfsonmicro.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

If Samsung are going to be doing their upstreaming stuff it may make
sense to merge this via ASoC since I anticipate some changes there, but
on the other hand that seems to have ground to a halt and the merge may
well go smoothly anyway.  My standard answer here would be putting the
patch on a branch by itself so if there are any issues it can be merged
into both trees to avoid the merge issues.
