From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Sun, 26 Feb 2017 22:57:58 +0800
Subject: [PATCH v5 2/7] clk: sunxi-ng: rename sun8i-h3 driver to
 sunxi-h3-h5
In-Reply-To: <20170226095204.cwh7f2mbgjumr5fu@localhost>
References: <20170226011956.53581-1-icenowy@aosc.xyz>
 <20170226011956.53581-3-icenowy@aosc.xyz>
 <20170226095204.cwh7f2mbgjumr5fu@localhost>
Message-ID: <10821061488121078@web18g.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



26.02.2017, 17:52, "Rask Ingemann Lambertsen" <rask@formelder.dk>:
> On Sun, Feb 26, 2017 at 09:19:51AM +0800, Icenowy Zheng wrote:
>> ?As the CCU in the Allwinner H5 SoC is very similar to the one in H3,
>> ?rename the H3 driver to sunxi-h3-h5 so that it can be extended with H5
>> ?support.
>>
>> ?Trasitional header symlinks are created, to ensure current device tree
>
> s/Trasitional/Transitional/ I guess.
>
>> ?files which included sun8i-h3-ccu.h can compile.
>>
>> ?Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
>> ?---
>> ?Changes in v5:
>> ?- Add the reason to create trasitional headers in commit message.
>
> Likewise.

Thanks ;-)

>
> --
> Rask Ingemann Lambertsen
