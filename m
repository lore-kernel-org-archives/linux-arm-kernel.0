From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue, 28 Feb 2017 16:35:31 +0800
Subject: [PATCH v5 2/3] nvmem: sunxi-sid: add support for H3's SID
 controller
In-Reply-To: <20170228064258.mqpu33udgokxazkz@lukather>
References: <20170227192715.50198-1-icenowy@aosc.xyz>
 <20170227192715.50198-2-icenowy@aosc.xyz>
 <20170228064258.mqpu33udgokxazkz@lukather>
Message-ID: <630891488270931@web10m.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



28.02.2017, 14:43, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
> On Tue, Feb 28, 2017 at 03:27:14AM +0800, Icenowy Zheng wrote:
>> ?The H3 SoC have a bigger SID controller, which has its direct read
>> ?address at 0x200 position in the SID block, not 0x0.
>>
>> ?Also, H3 SID controller has some silicon bug that makes the direct read
>> ?value wrong at cold boot, add code to workaround the bug. (This bug has
>> ?already been fixed on A64 and later SoCs)
>>
>> ?Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Who will finally apply these patches?

I have seen that you are one of the maintainers of NVMEM subsystem.

>
> Thanks!
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
