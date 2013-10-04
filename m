From: bcousson@baylibre.com (Benoit Cousson)
Date: Fri, 04 Oct 2013 16:10:43 +0200
Subject: [PATCH v2 0/9] ARM: dts: DT data for OMAP platforms for v3.13
In-Reply-To: <524E213B.6030306@ti.com>
References: <1380553986-15910-1-git-send-email-joelf@ti.com>
 <524D7038.9070303@baylibre.com> <524E213B.6030306@ti.com>
Message-ID: <524ECC63.3050303@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/2013 04:00, Joel Fernandes wrote:
> On 10/03/2013 08:25 AM, Benoit Cousson wrote:
>> + DT list and DT maintainers.
>>
>> Hi Joel,
>>
>> Thanks for the update. It looks good to me.
>>
>> For the new bindings added below;
>>
>>>    .../devicetree/bindings/crypto/omap-aes.txt        | 34 ++++++++++
>>>    .../devicetree/bindings/crypto/omap-sham.txt       | 31 +++++++++
>>
>> I will need the acked-by from one of the DT maintainers.
>
> Sure. To help with giving Ack for this, I'd like to also mention these patches
> were due for long time and reposted. The supporting code is already in the kernel.
>
> Also bindings were reviewed by Mark Rutland comments in the following thread
> were addressed:
> http://www.spinics.net/lists/arm-kernel/msg269006.html

OK, that's good news, at least it was already reviewed by Mark.

I'm fixing and pulling the series, and will add Mark's Acked-by as soon 
as he will send it.

Meanwhile some nits, I'm fixing myself this time :-)

None of your subjects is following the same guideline and the repertory 
guideline...

   omap4: dts: Add node for AES
   omap4: dts: Add node for DES3DES module
   am33xx: dts: Fix AES interrupt number
   ARM: am437x: dts: Add AES node for am437x
   ARM: am437x: dts: Add DES node for am437x

It should be ARM: dts: OMAPXXX or AMXXX...

Regards,
Benoit
