From: jacobchen110@gmail.com (Jacob Chen)
Date: Mon, 17 Jul 2017 11:44:51 +0800
Subject: [PATCH 1/5] arm64: dts: rockchip: Add rk3399 vop and
 display-subsystem
In-Reply-To: <71446982.CYE3jZejiS@phil>
References: <1499875435-23944-1-git-send-email-jacob-chen@iotwrt.com>
 <1499875435-23944-2-git-send-email-jacob-chen@iotwrt.com>
 <71446982.CYE3jZejiS@phil>
Message-ID: <CAFLEztTAa8jPMNYO8iAgybGFTerCDBqwLUrjbKOfFqEE++oXhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi heko,

2017-07-17 1:31 GMT+08:00 Heiko Stuebner <heiko@sntech.de>:
> Hi Jacob,
>
> Am Donnerstag, 13. Juli 2017, 00:03:51 CEST schrieb Jacob Chen:
>> Add devicetree nodes for rk3399 VOP (Video Output Processors), and the
>> top level display-subsystem root node.
>>
>> Later patches add endpoints (eDP, HDMI, MIPI, etc) that attach to the
>> VOPs' output ports.
>>
>> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
>> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>> Signed-off-by: Jacob Chen <jacob-chen@iotwrt.com>
>
> you might want to reduce the number of Signed-offs a bit :-)
>
> Also authorship needs to be fixed. I.e. first Signed-off for this patch
> is from Mark, so in that case Mark probably also was the original author
> and the patch should reflect that. General rule, topmost Signed-off is
> of course from the original author.
>

OK, get it.

>
> Heiko
>
