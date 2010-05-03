From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Mon, 3 May 2010 22:15:16 +0300
Subject: [PATCH v6 1/2] spi: implemented driver for Cirrus EP93xx SPI
	controller
In-Reply-To: <0D753D10438DA54287A00B0270842697636EADDB8E@AUSP01VMBX24.collaborationhost.net>
References: <cover.1272805161.git.mika.westerberg@iki.fi>
	<0dce0e9fdb6af35854d26d7bd0d8af5a5ea8f76a.1272805161.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B0270842697636EADDB8E@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20100503191516.GP26418@gw.healthdatacare.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 03, 2010 at 01:45:01PM -0500, H Hartley Sweeten wrote:
(...)
> 
> Overall this looks good.
> 
> For the modified chip select support, you have my:
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> 
> For the ep93xx driver in general, you have my:
> 
> Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> 
> This driver should probably go through the spi tree.  You will need Grant Likely
> to Ack this and pick it up.

Thanks Hartley!

I will incorporate your latest comments and submit v7.

Grant: do you have any comments on this? Is it ok for you to cycle
this through your spi tree?

Thanks,
MW
