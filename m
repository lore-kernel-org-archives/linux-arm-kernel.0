From: stefan@agner.ch (Stefan Agner)
Date: Tue, 01 Aug 2017 19:41:41 -0700
Subject: [PATCH v6 0/3] ARM: dts: imx7: add NAND support
In-Reply-To: <20170614151146.GC30112@dragon>
References: <cover.9fab78eaa869dbad4c9ad7e8578c9cef3e49daa8.1496961128.git-series.stefan@agner.ch>
 <20170614151146.GC30112@dragon>
Message-ID: <c05aff108433c9ced4c85efcf3ba65e8@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On 2017-06-14 08:11, Shawn Guo wrote:
> On Thu, Jun 08, 2017 at 03:34:46PM -0700, Stefan Agner wrote:
>> Stefan Agner (3):
>>   clk: imx7d: create clocks behind rawnand clock gate
>>   ARM: dts: imx7: add GPMI NAND and APBH DMA
>>   ARM: dts: imx7-colibri: add NAND support
> 
> Both dts patches look good to me.  Please ping me after the clk patch
> lands on mainline.

The clk patch landed in mainline. These two patches seem to apply fine
still. Can you queue them for -next?

FWIW, tested it on a Colibri iMX7 using v3.13-rc3, works fine after
reverting the GPC changes (see my other email with subject "i.MX 7 boot
freeze with 4.13-rc3").

--
Stefan
