From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 18 Nov 2013 15:06:19 +0000
Subject: [PATCHv3] ASoC: Add support for BCM2835
In-Reply-To: <528A232B.9070402@metafoo.de>
References: <5289F9DF.8060406@koalo.de>
 <20131118141637.GI30853@e106331-lin.cambridge.arm.com>
 <528A232B.9070402@metafoo.de>
Message-ID: <20131118150619.GL30853@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 18, 2013 at 02:24:43PM +0000, Lars-Peter Clausen wrote:
> On 11/18/2013 03:16 PM, Mark Rutland wrote:
> > 
> >> +static void bcm2835_i2s_stop_clock(struct bcm2835_i2s_dev *dev)
> >> +{
> >> +       uint32_t clkreg;
> > 
> > s/uint32_t/u32/ (and elsewhere...)
> 
> Please don't do that.
> 

I was under the impression that there was a preference for uXX types
over uintXX_t types, but the replies and Documentation/CodingStyle have
taught me otherwise.

Apologies for the confusion here.

Thanks,
Mark.
