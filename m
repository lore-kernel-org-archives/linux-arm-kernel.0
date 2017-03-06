From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Mon, 06 Mar 2017 18:46:07 +0800
Subject: [PATCH v7 1/6] ARM: dts: sun8i: drop skeleton.dtsi inclusion in
 H3 DTSI
In-Reply-To: <20170306103535.jdaiwr65gtrhh7jp@lukather>
References: <20170305233138.64574-1-icenowy@aosc.xyz>
 <20170305233138.64574-2-icenowy@aosc.xyz>
 <20170306103535.jdaiwr65gtrhh7jp@lukather>
Message-ID: <1681991488797167@web29m.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



06.03.2017, 18:35, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
> Hi,
>
> On Mon, Mar 06, 2017 at 07:31:33AM +0800, Icenowy Zheng wrote:
>> ?The skeleton.dtsi file is now deprecated, and do not exist in ARM64
>> ?environment.
>>
>> ?Since we will soon reuse most part of H3 DTSI for H5, which is an ARM64
>> ?chip, drop skeleton.dtsi inclusion now.
>>
>> ?Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
>
> Your prefix (and in the three later patches) should be
> ARM: sun8i: h3

Oh I think we never added SoC name in prefix...

>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
