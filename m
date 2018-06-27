From: jernej.skrabec@gmail.com (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Wed, 27 Jun 2018 18:47:56 +0200
Subject: [linux-sunxi] [PATCH] ARM: dts: sun8i-h3: Increase the GPU clock
 to 576 MHz
In-Reply-To: <20180627072635.3592-1-paul.kocialkowski@bootlin.com>
References: <20180627072635.3592-1-paul.kocialkowski@bootlin.com>
Message-ID: <2117931.94GTsegy69@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

Dne sreda, 27. junij 2018 ob 09:26:35 CEST je Paul Kocialkowski napisal(a):
> It was reported (based on declarations from the Allwiner BSP) that the
> Mali 400 found on the H3 can be clocked up to 576 MHz.
> 
> The frequency was tested using the r6p2 out-of-tree driver and a Kodi
> userspace with associated r6p2 blobs, leading to a working result.
> 
> This increases the clock to 576 MHz, which directly increases the pixel
> throughput of the GPU (given the 1 pixel-per-cycle rate).

I think that current clock speed is on a bit conservative side because there 
is no thermal throttling support yet.

Best regards,
Jernej
