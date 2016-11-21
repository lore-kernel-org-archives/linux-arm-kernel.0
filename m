From: maitysanchayan@gmail.com (maitysanchayan at gmail.com)
Date: Tue, 22 Nov 2016 00:48:50 +0530
Subject: [PATCH v2 1/4] spi: spi-fsl-dspi: Fix SPI transfer issue when
 using multiple SPI_IOC_MESSAGE
In-Reply-To: <20161121191430.GA24521@Sanchayan-Arch.localdomain>
References: <cover.1479706671.git.maitysanchayan@gmail.com>
 <bbdbc8df434dd2af74eb351b799a2812a1c1967e.1479706671.git.maitysanchayan@gmail.com>
 <20161121191847.vg32cwople4qmini@sirena.org.uk>
 <20161121191430.GA24521@Sanchayan-Arch.localdomain>
Message-ID: <20161121191850.GB24521@Sanchayan-Arch.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

On 16-11-22 00:44:30, maitysanchayan at gmail.com wrote:
> Hello Mark,
> 
> On 16-11-21 19:18:47, Mark Brown wrote:
> > On Mon, Nov 21, 2016 at 11:24:01AM +0530, Sanchayan Maity wrote:
> > > Current DMA implementation had a bug where the DMA transfer would
> > > exit the loop in dspi_transfer_one_message after the completion of
> > > a single transfer. This results in a multi message transfer submitted
> > > with SPI_IOC_MESSAGE to terminate incorrectly without an error.
> > 
> > Please don't resend already applied patches.  If there are any changes
> > needed please send incremental changes on top of what's already applied.
> 
> This is not a resend of an applied patch. The whole series applies on
> top of your topic/fsl-dspi branch and has fixes for the SPI DMA as
> incremental changes
> 
Sorry. I take that back. I now see you applied the patch and I got the applied
mail after I replied.

- Sanchayan.
