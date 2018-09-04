From: icenowy@aosc.io (Icenowy Zheng)
Date: Tue, 04 Sep 2018 16:44:30 +0800
Subject: [linux-sunxi] Re: [PATCH 02/27] arm64: allwinner: h6: add system
 controller device tree node
In-Reply-To: <CAGb2v65y1W=52SAFFqyCOnHd80nx+oPHUDeysHWBy7o8_g=eeQ@mail.gmail.com>
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
 <20180902072643.4917-3-jernej.skrabec@siol.net>
 <CAGb2v65y1W=52SAFFqyCOnHd80nx+oPHUDeysHWBy7o8_g=eeQ@mail.gmail.com>
Message-ID: <9915D9F1-1C60-4AEF-9074-CE040FCD7BF0@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018?9?4? GMT+08:00 ??4:40:56, Chen-Yu Tsai <wens@csie.org> ??:
>On Sun, Sep 2, 2018 at 3:27 PM Jernej Skrabec <jernej.skrabec@siol.net>
>wrote:
>>
>> From: Icenowy Zheng <icenowy@aosc.io>
>>
>> As we have already binding for the H6 system controller, add its node
>> to the device tree.
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> [fixed compatible string]
>> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
>
>Reviewed-by: Chen-Yu Tsai <wens@csie.org>

By the way can these patches be applied first? (patches
related to syscon).

They're also needed for EMAC.
