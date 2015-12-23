From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 23 Dec 2015 21:15:53 +0900
Subject: [PATCH v9 0/4] Exynos SROMc configuration and Ethernet support
 for SMDK5410
In-Reply-To: <019e01d13974$c432fb00$4c98f100$@samsung.com>
References: <cover.1447659546.git.p.fedin@samsung.com>
 <56724519.80108@samsung.com> <019e01d13974$c432fb00$4c98f100$@samsung.com>
Message-ID: <567A9079.9030400@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 18.12.2015 o 18:16, Pavel Fedin pisze:
>  Hello!
> 
>> 4. This branch is not pushed to linux-next. I will sort it out if my
>> previous pull requests get in. I will be out of office for Christmas so
>> depending on the timing of {arm-soc,Christmas,Kukjin} this may or may
>> not go into v4.5 (yay...).
>>
>> 5. If it does not get into v4.5, I will rebase it and proceed further
>> for v4.6.
>>
>> If you have any questions, please let me know.
> 
>  Thank you very much. No, i don't have any questions, i'm glad that my work is picked up and not lost, i'm just keeping an eye on it
> until it goes to stable.
> 
>  P.S. Not related to these sets directly, just to note... When i was writing the doc for SROMc bindings, i noticed that we have two
> directories for Exynos in Documentation/devicetree/bindings/arm:
> 1. Documentation/devicetree/bindings/arm/exynos
> 2. Documentation/devicetree/bindings/arm/Samsung
> 
>  In (1) we have only a single old file, shouldn't this be cleaned up and shouldn't this file be moved to (2)?

Thanks for hind but I already cleaned it up:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=068812ed108acbfe070b893faba9845fe2ea3fd9

Best regards,
Krzysztof
