From: broonie@kernel.org (Mark Brown)
Date: Tue, 22 Nov 2016 16:22:51 +0000
Subject: [PATCH v2 1/4] spi: spi-fsl-dspi: Fix SPI transfer issue when
 using multiple SPI_IOC_MESSAGE
In-Reply-To: <20161121191850.GB24521@Sanchayan-Arch.localdomain>
References: <cover.1479706671.git.maitysanchayan@gmail.com>
 <bbdbc8df434dd2af74eb351b799a2812a1c1967e.1479706671.git.maitysanchayan@gmail.com>
 <20161121191847.vg32cwople4qmini@sirena.org.uk>
 <20161121191430.GA24521@Sanchayan-Arch.localdomain>
 <20161121191850.GB24521@Sanchayan-Arch.localdomain>
Message-ID: <20161122162251.x7uheu47426g3mpg@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2016 at 12:48:50AM +0530, maitysanchayan at gmail.com wrote:
> On 16-11-22 00:44:30, maitysanchayan at gmail.com wrote:

> > This is not a resend of an applied patch. The whole series applies on
> > top of your topic/fsl-dspi branch and has fixes for the SPI DMA as
> > incremental changes

> Sorry. I take that back. I now see you applied the patch and I got the applied
> mail after I replied.

Ah, I did apply it on Friday but somehow it didn't get pushed until
yesterday.  Sorry for the confusion.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 455 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161122/ce824c66/attachment.sig>
