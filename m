From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 17 Apr 2018 12:02:54 +0200
Subject: [PATCH 3/6] spi: spi-s3c64xx: Drop unused enable_datapath()
 function argument
In-Reply-To: <167c0f1a1a9de44574523c7f4a9d137d@etezian.org>
References: <20180416154021.25626-1-s.nawrocki@samsung.com>
 <CGME20180416154122epcas1p1ae714af12f8da08783c47fcd820c40e7@epcas1p1.samsung.com>
 <20180416154021.25626-3-s.nawrocki@samsung.com>
 <167c0f1a1a9de44574523c7f4a9d137d@etezian.org>
Message-ID: <71b98ebb-550e-60af-36cb-0196cf738e54@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andi,

On 04/16/2018 09:09 PM, andi at etezian.org wrote:
> On 17.04.2018 00:40, Sylwester Nawrocki wrote:
>> The spi pointer argument is not used now so remove it. While at it
>> s3c64xx_ prefix is added to the function name.
>
> These for me are two different patches, but in any case it's trivial
> so that I don't mind it too much.

I am going to drop renaming from this patch. There are 2 more functions
(wait_for_pio(), wait_for_dma()) without prefix, should we rename them
too or rather leave all 3 as they are now?

-- 
Regards,
Sylwester
