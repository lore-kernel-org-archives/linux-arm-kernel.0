From: olof@lixom.net (Olof Johansson)
Date: Wed, 4 Dec 2013 09:30:19 -0800
Subject: Boot time errors/warnings on snowball
In-Reply-To: <20131204172626.GB26581@lee--X1>
References: <CAOesGMgwyU-fJWkiF+78US+vVZ7Ensku-j+O1UPFVt43WDfUsA@mail.gmail.com>
 <CACRpkda3V4bK3_QO76=++Gcm3pJp78G2L3pgAdaJb2NDcAJG6Q@mail.gmail.com>
 <20131204172626.GB26581@lee--X1>
Message-ID: <CAOesGMgFLLrVtUTJEqaDZGBxihYUSMbLjQu=vLT=udCq2Z6baw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 4, 2013 at 9:26 AM, Lee Jones <lee.jones@linaro.org> wrote:
>> > I noticed these with last night's -next on the snowball:
>> >
>> > of_dma_request_slave_channel: dma-names property of node
>> > '/soc/msp at 80124000' missing or empty
>> > of_dma_request_slave_channel: dma-names property of node
>> > '/soc/msp at 80124000' missing or empty
>> > of_dma_request_slave_channel: dma-names property of node
>> > '/soc/msp at 80125000' missing or empty
>> > of_dma_request_slave_channel: dma-names property of node
>> > '/soc/msp at 80125000' missing or empty
>> > dma dma0chan22: [d40_config_memcpy] No memcpy`
>> > dma dma0chan22: [d40_alloc_chan_resources] Failed to configure memcpy channel
>> > ux500-msp-i2s ux500-msp-i2s.1: Missing dma channel for stream: 0
>> > ux500-msp-i2s ux500-msp-i2s.1: ASoC: pcm constructor failed: -22
>>
>> I don't see this when booting from the stuff I sent for v3.14,
>> but I know Mark applied some fixes from Lee yesterday,
>> Lee can you see if you recognize this?
>
> It looks like whatever tree you're building from is missing this patch:
>
>   ARM: ux500: Add DMA config bindings for MSP devices

FWIW, this was with next-20131204.


-Olof
