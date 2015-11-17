From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 17 Nov 2015 10:57:48 +0900
Subject: [PATCH] cpufreq: do not mark s3c2410_plls_add as __init
In-Reply-To: <4389196.cuM78vZZnJ@wuerfel>
References: <8497197.sYxqVOch7s@wuerfel> <28389377.zxoR5rtJ13@vostro.rjw.lan>
 <4389196.cuM78vZZnJ@wuerfel>
Message-ID: <564A899C.4040402@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17.11.2015 07:17, Arnd Bergmann wrote:
> On Monday 16 November 2015 23:36:42 Rafael J. Wysocki wrote:
>>
>> This should go in through the Samsung tree, so I'll leave it for them to pick
>> it up (at least for the time being).
> 
> Ok, fair enough. Kukjin or Krzysztof, can you pick this up?

Sure.

As for the patch I think everything can be converted to init/initdata
(as in attachment).

Best regards,
Krzysztof



-------------- next part --------------
A non-text attachment was scrubbed...
Name: init_data.patch
Type: text/x-patch
Size: 3760 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151117/3cab94a0/attachment.bin>
