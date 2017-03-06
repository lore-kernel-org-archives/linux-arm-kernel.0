From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 6 Mar 2017 18:48:34 +0800
Subject: [linux-sunxi] Re: [PATCH v7 1/6] ARM: dts: sun8i: drop
 skeleton.dtsi inclusion in H3 DTSI
In-Reply-To: <1681991488797167@web29m.yandex.ru>
References: <20170305233138.64574-1-icenowy@aosc.xyz>
 <20170305233138.64574-2-icenowy@aosc.xyz>
 <20170306103535.jdaiwr65gtrhh7jp@lukather> <1681991488797167@web29m.yandex.ru>
Message-ID: <CAGb2v64gDZ4=28Etwrv0eb=vAVEp1hh6ek9+18irRPvos7vJcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 6, 2017 at 6:46 PM, Icenowy Zheng <icenowy@aosc.xyz> wrote:
>
>
> 06.03.2017, 18:35, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
>> Hi,
>>
>> On Mon, Mar 06, 2017 at 07:31:33AM +0800, Icenowy Zheng wrote:
>>>  The skeleton.dtsi file is now deprecated, and do not exist in ARM64
>>>  environment.
>>>
>>>  Since we will soon reuse most part of H3 DTSI for H5, which is an ARM64
>>>  chip, drop skeleton.dtsi inclusion now.
>>>
>>>  Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
>>
>> Your prefix (and in the three later patches) should be
>> ARM: sun8i: h3
>
> Oh I think we never added SoC name in prefix...

It's better to add them for sun8i, which encompasses a whole
bunch of SoCs, unlike the older sun[4-7]i. Even sun5i patches
have them.

ChenYu
