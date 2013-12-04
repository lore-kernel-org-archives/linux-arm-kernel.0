From: olof@lixom.net (Olof Johansson)
Date: Wed, 4 Dec 2013 08:37:11 -0800
Subject: Boot time errors/warnings on snowball
Message-ID: <CAOesGMgwyU-fJWkiF+78US+vVZ7Ensku-j+O1UPFVt43WDfUsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I noticed these with last night's -next on the snowball:

of_dma_request_slave_channel: dma-names property of node
'/soc/msp at 80124000' missing or empty
of_dma_request_slave_channel: dma-names property of node
'/soc/msp at 80124000' missing or empty
of_dma_request_slave_channel: dma-names property of node
'/soc/msp at 80125000' missing or empty
of_dma_request_slave_channel: dma-names property of node
'/soc/msp at 80125000' missing or empty
dma dma0chan22: [d40_config_memcpy] No memcpy
dma dma0chan22: [d40_alloc_chan_resources] Failed to configure memcpy channel
ux500-msp-i2s ux500-msp-i2s.1: Missing dma channel for stream: 0
ux500-msp-i2s ux500-msp-i2s.1: ASoC: pcm constructor failed: -22



-Olof
