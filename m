From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 15 Sep 2016 20:16:15 +0530
Subject: [PATCH v2] ARM: dts: da850-lcdk: Add NAND to DT
In-Reply-To: <CAOi56cWJpx-+s7h_+qypj-0HOcC2vDs2PLtZbdMO92TzdvECpQ@mail.gmail.com>
References: <20160908183324.32389-1-khilman@baylibre.com>
 <CAOi56cWJpx-+s7h_+qypj-0HOcC2vDs2PLtZbdMO92TzdvECpQ@mail.gmail.com>
Message-ID: <15cf4422-0ad6-9927-92fe-b32ab61f86d5@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Wednesday 14 September 2016 10:54 PM, Kevin Hilman wrote:
> Hi Sekhar,
> 
> On Thu, Sep 8, 2016 at 11:33 AM, Kevin Hilman <khilman@baylibre.com> wrote:
>> From: Karl Beldan <kbeldan@baylibre.com>
>>
>> This adds DT support for the NAND connected to the SoC AEMIF.
>> Passed torture hashing a 40MB file on top of UBIFS using subpages.
>>
>> Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
>> [khilman: add back default partitions from an earlier patch]
>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>> ---
>> Applies on Sekhar's v4.9/dts branch.
>>
> 
> Looks like you need to respin your DT series for arm-soc due to build
> errors.  Can you add this while you're at it so we have 4-bit ECC in
> v4.9?

The comments in the patch were fine. I applied this patch and just sent
a pull request for ARM-SoC maintainers too. Hopefully its not too late
for v4.9

Thanks,
Sekhar
