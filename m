From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 26 Feb 2016 19:55:50 +0900
Subject: [RESPIN 0/6] Add support for Exynos SROM Controller driver.
In-Reply-To: <00c701d17070$6de3d1b0$49ab7510$@samsung.com>
References: <1456389222-12738-1-git-send-email-pankaj.dubey@samsung.com>
 <56D0040C.8020204@samsung.com>
 <00c701d17070$6de3d1b0$49ab7510$@samsung.com>
Message-ID: <CAJKOXPdZ-5WYYvqiNTMUnP6WsxAK4gqsi4o5SMJF+_SJa1qbag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-02-26 17:33 GMT+09:00 Pavel Fedin <p.fedin@samsung.com>:
>  Hello!
>
>> I applied (with fixes mentioned in my comments) everything and pushed
>> here so everyone could play with it:
>> https://git.kernel.org/cgit/linux/kernel/git/krzk/linux.git/log/?h=for-v4.6/drivers-soc-
>> exynos-srom-2
>
>  I see the last patch (adding Ethernet chip to DT) is missing. Is it intentional, so that it goes later?
>

It was already merged into arm-soc:
https://git.kernel.org/cgit/linux/kernel/git/arm/arm-soc.git/commit/?h=next/dt&id=a090435727f6ccf0c5e77793ca48681122e5b950

All DT changes (SROM, PMU) were accepted by arm-soc maintainers.

Best regards,
Krzysztof
