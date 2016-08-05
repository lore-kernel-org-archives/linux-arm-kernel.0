From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 5 Aug 2016 20:22:34 +0530
Subject: [PATCH] ARM: dts: da850: Add basic DTS for the L138/C6748 Dev Kit
In-Reply-To: <20160805144507.GA24855@gobelin>
References: <20160804144332.4841-1-kbeldan@baylibre.com>
 <57A49F3A.9030306@ti.com> <20160805144507.GA24855@gobelin>
Message-ID: <57A4A832.1000201@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 August 2016 08:15 PM, Karl Beldan wrote:
> On Fri, Aug 05, 2016 at 07:44:18PM +0530, Sekhar Nori wrote:
>> On Thursday 04 August 2016 08:13 PM, Karl Beldan wrote:
>>> The LCDK is the successor to the late Hawkboard and has the same machine
>>> number.
>>> Among the differences are the flash (16bits vs 8bits) and some pins
>>> (MMC, LEDs, buttons, some external connectors), however the main
>>> components remain the same (eth. PHY, Audio Codec, Video decoder and
>>> DAC) except for the main PMIC, different and hard-wired on the LCDK (the
>>> LDOs and DCDCs are always ON).
>>> A DT-only boot with this addition gives functional uart, reboot via
>>> watchdog, rtc, ethernet and MMC (I added the CD gpio for the MMC
>>> although davinci_mmc doesn't call yet the mmc core OF facilities).
>>>
>>> Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
>>
>> C6748 is a pin-compatible DSP-only part which does not run Linux. The
>> OMAP-L138 and C6748 LCDKs are physically different boards. So, I would
>> just stick with subject line ".. for the OMAP-L138 LCDK board"
>>
> That was my understanding but LCDK stands for L138-C6748-Dev-Kit right ?
> Anyways, I'll remove the said references as per your request.

You are right. And now that you clarify that, I think I am okay leaving
what you have as-it-is. Use of C6748 threw me off. But thats just the
acronym expansion.

Thanks,
Sekhar
