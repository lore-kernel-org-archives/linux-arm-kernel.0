From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 13 May 2015 16:40:36 +0900
Subject: [PATCHv5 5/5] ARM: dts: Enable thermal_zone for
 exynos5422-odroidxu3
In-Reply-To: <1431499020-3912-6-git-send-email-linux.amoon@gmail.com>
References: <1431499020-3912-1-git-send-email-linux.amoon@gmail.com>
 <1431499020-3912-6-git-send-email-linux.amoon@gmail.com>
Message-ID: <CAJKOXPeNB=BXoY6CAxE8MNZ90cchhbdbUg3Xgef3qAgBR2UWJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-13 15:37 GMT+09:00 Anand Moon <linux.amoon@gmail.com>:
> Include exynos5-cpu-thermal.dtsi to enable thermal_zone support.

I am a little confused because you named this file as
exynos5-cpu-thermal, meaning it is common for all Exynos5 boards. But:
1. It references some specific phandles like &fan0 (cooling-device =
<&fan0 2 3>).
2. You include it only here.

So the question: is "exynos5-cpu-thermal.dtsi" a generic thermal DTSI?
What is your intention?

Lukasz, you acked the patchset, is it fine?

Best regards,
Krzysztof
