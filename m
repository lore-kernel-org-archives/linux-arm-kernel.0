From: pullip.cho@samsung.com (KyongHo Cho)
Date: Sat, 8 Oct 2011 22:25:45 +0900
Subject: [PATCH v3 RE-SEND 2/2] iommu/exynos: Add iommu driver for Exynos
	Platforms
In-Reply-To: <4E8F6532.9060609@gmail.com>
References: <01e601cc84d9$4530d6a0$cf9283e0$%kim@samsung.com>
	<4E8F6532.9060609@gmail.com>
Message-ID: <CAHQjnOPRvjD1X-T3w1yDKhf5QLq9rz9Vc2vs2yzU1xynFx-Wow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 8, 2011 at 5:46 AM, Sylwester Nawrocki
<sylvester.nawrocki@gmail.com> wrote:
>> -
>> -config S5P_SLEEP
>> - ? ? bool
>> - ? ? help
>> - ? ? ? Internal config node to apply common S5P sleep management code.
>> - ? ? ? Can be selected by S5P and newer SoCs with similar sleep procedure.
>> -
>
> Is S5P_SLEEP being removed intentionally ? It doesn't seem to belong here.

No, it is a mistake while rebasing the patches.

Thank you for pointing that.
