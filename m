From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 19 Aug 2016 19:38:52 +0530
Subject: [PATCH v2] ARM: dts: da850-lcdk: Audio support via simple-card
In-Reply-To: <m2vayy6y6s.fsf@baylibre.com>
References: <20160817125454.20717-1-kbeldan@baylibre.com>
 <m2vayy6y6s.fsf@baylibre.com>
Message-ID: <5d210466-def6-c19e-fce4-2b9730e13e2e@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 August 2016 06:17 PM, Kevin Hilman wrote:
> Karl Beldan <kbeldan@baylibre.com> writes:
> 
>> The LCDK embeds a TLV320AIC3106 connected to the SoC McASP for analog
>> audio. The power supply of the codec comes from the main PMIC
>> (TPS650250) DCDCs which are always on per HW design and not
>> controllable by SW, so SW wise the codec driver will rely on the 'dummy'
>> regulator.
>> Quality is good with arecord -pipe- aplay on Line In/Line Out.
>>
>> Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
> 
> Tested pass through: "arecord -f cd | aplay -" on DA850-LCDK.
> 
> Tested-by: Kevin Hilman <khilman@baylibre.com>

Applied to v4.9/dts of my tree.

Thanks,
Sekhar
