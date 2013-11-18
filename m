From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon, 18 Nov 2013 15:24:43 +0100
Subject: [PATCHv3] ASoC: Add support for BCM2835
In-Reply-To: <20131118141637.GI30853@e106331-lin.cambridge.arm.com>
References: <5289F9DF.8060406@koalo.de>
 <20131118141637.GI30853@e106331-lin.cambridge.arm.com>
Message-ID: <528A232B.9070402@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/2013 03:16 PM, Mark Rutland wrote:
> 
>> +static void bcm2835_i2s_stop_clock(struct bcm2835_i2s_dev *dev)
>> +{
>> +       uint32_t clkreg;
> 
> s/uint32_t/u32/ (and elsewhere...)

Please don't do that.
