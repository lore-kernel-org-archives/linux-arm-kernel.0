From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 07 Jul 2016 17:26:13 +0200
Subject: [PATCH v4 0/2] mark spi clocks as critical and enable spi3 clocks
In-Reply-To: <577E56A6.6010301@samsung.com>
References: <1467893637-12573-1-git-send-email-andi.shyti@samsung.com>
 <577E56A6.6010301@samsung.com>
Message-ID: <577E7495.2010904@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/07/2016 03:18 PM, Sylwester Nawrocki wrote:
> On 07/07/2016 02:13 PM, Andi Shyti wrote:
>> > Andi Shyti (2):
>> >   clk: exynos5433: do not use CLK_IGNORE_UNUSED for SPI clocks
>> >   clk: exynos5433: enable sclk_ioclk for SPI3
>
> Applied both patches, thanks.

Apologies for the confusion, I had to drop these patches for reasons
explained in the other thread. We just need to simply drop
CLK_IGNORE_UNUSED flags and get the driver controlling clocks which
belong to the peripheral IP block.
