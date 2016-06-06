From: christopher.spinrath@rwth-aachen.de (Christopher Spinrath)
Date: Mon, 6 Jun 2016 19:24:56 +0200
Subject: [PATCH v2 4/4] ARM: dts: imx6q-cm-fx6: Relicense under GPLv2/X11
In-Reply-To: <c2c21863a715471880d2369d111bc28e@rwthex-s1-b.rwth-ad.de>
References: <20160605182657.1706-1-christopher.spinrath@rwth-aachen.de>
 <c2d37f17a8b049169909c7a9391fa9a3@rwthex-s1-b.rwth-ad.de>
 <c2c21863a715471880d2369d111bc28e@rwthex-s1-b.rwth-ad.de>
Message-ID: <a07d079d2dcd4a55a09b66486324d399@rwthex-s1-b.rwth-ad.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Igor,

On 06/06/2016 09:53 AM, Igor Grinberg wrote:
> Hi Christopher,
> 
> On 06/05/2016 09:26 PM, christopher.spinrath at rwth-aachen.de wrote:
>> From: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
>>
>> GPLv2-only devicetrees make reuse difficult for software components
>> licensed under a different license. In particular, the Utilite Pro
>> devicetree file (which includes on imx6q-cm-fx5.dts) is already dual
>                                                ^^^
> That's a downgrade ;-)
> With the above fixed, please add my ack below.
> 

uups, I will fix it.

Thanks,
Christopher

>> licensed under GPLv2/X11.
>>
>> Hence, relicense imx6q-cm-fx6.dts under GPLv2/X11 dual license.
> 
> Off topic of this patch, I think SPDX works much better than having
> this huge license "hat" in each file.
> 
>>
>> Signed-off-by: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
>> Cc: Igor Grinberg <grinberg@compulab.co.il>
> 
> Acked-by: Igor Grinberg <grinberg@compulab.co.il>
> 

[...]
