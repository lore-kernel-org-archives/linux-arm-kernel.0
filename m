From: wolfram@the-dreams.de (Wolfram Sang)
Date: Tue, 12 Feb 2013 11:34:43 +0100
Subject: [PATCH V4] i2c: add bcm2835 driver
In-Reply-To: <1360637276-7899-1-git-send-email-swarren@wwwdotorg.org>
References: <1360637276-7899-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130212103443.GC5490@nekote.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 11, 2013 at 07:47:56PM -0700, Stephen Warren wrote:
> This implements a very basic I2C host driver for the BCM2835 SoC. Missing
> features so far are:
> 
> * 10-bit addressing.
> * DMA.
> 
> Reviewed-by: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>

Applied to for-next, thanks!
