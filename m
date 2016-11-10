From: ckeepax@opensource.wolfsonmicro.com (Charles Keepax)
Date: Thu, 10 Nov 2016 15:18:16 +0000
Subject: [PATCH RFC 2/7] ARM: S3C64XX: Add DMA slave maps for PL080 devices
In-Reply-To: <b654d5f7-7b67-7216-760f-d29e49a29296@samsung.com>
References: <1478276094-19135-1-git-send-email-s.nawrocki@samsung.com>
 <1478276094-19135-4-git-send-email-s.nawrocki@samsung.com>
 <20161108144445.GD1575@localhost.localdomain>
 <CGME20161108145620epcas2p4b8e2ec5ffdd4bf04ab3bf0728b46e3f2@epcas2p4.samsung.com>
 <20161108145534.GE1575@localhost.localdomain>
 <f53d533d-163f-31f3-4efb-0e39d201589d@samsung.com>
 <20161110110323.GG1575@localhost.localdomain>
 <b654d5f7-7b67-7216-760f-d29e49a29296@samsung.com>
Message-ID: <20161110151816.GI1575@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2016 at 04:10:56PM +0100, Sylwester Nawrocki wrote:
> On 11/10/2016 12:03 PM, Charles Keepax wrote:
> >> On Tue, Nov 08, 2016 at 04:53:40PM +0100, Sylwester Nawrocki wrote:
> [...]
> >> I pushed now to branch for-v4.10/dma/pl080-s3c64xx-v2 with this
> >> issue fixed and added initialization of the filer function.
> > 
> > Apologies for the delay got somewhat swamped with internal stuff
> > yesterday. Yeah using that branch it looks good to me, the SPI and
> > I2S are both working fine. I can download code to the wm0010
> > which should be a good work out of the SPI and play audio
> > correctly so the I2S should be fine. So for the series:
> > 
> > Tested-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> 
> Great, thanks a lot!  I'm going to post the next iteration with
> modified pl080 DMAC patches, addressing comments from Arnd.
> I would be grateful if you could confirm it also works on your
> platform.
> 

Yeah, no problem, I should be able to find time to test those as
well.

Thanks,
Charles
