From: zyw@rock-chips.com (Chris Zhong)
Date: Mon, 18 Dec 2017 08:48:40 +0800
Subject: [PATCH v2] ARM: dts: add reset property for rk3066a-rayeager emac
 phy
In-Reply-To: <9893397.vbQdaeDkgV@phil>
References: <1510134642-18797-1-git-send-email-zyw@rock-chips.com>
 <9893397.vbQdaeDkgV@phil>
Message-ID: <f925b22d-6d70-8406-62f7-6e447749a223@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko

Thanks :)


On 2017?12?17? 04:11, Heiko Stuebner wrote:
> Hi Chris,
>
> Am Mittwoch, 8. November 2017, 17:50:41 CET schrieb Chris Zhong:
>> The ethernet phy of rk3066a-rayeager has a reset pin, it controlled by
>> GPIO1_D6, this pin should be pull down then pull up to reset the phy.
>> Add a reset-gpios property in phy0, make the phy can be reset when emac
>> power on.
>>
>> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
>> ---
>>
>> Changes in v2:
>> use a generic property for reset, and this patch follow these 2 pathes
>> from Geert Uytterhoeven <geert+renesas@glider.be>
>> http://patchwork.ozlabs.org/patch/828499/
>> http://patchwork.ozlabs.org/patch/828505/
> looks like the phylib-patches were accepted some days ago,
> so I've now also applied this patch for 4.16, after fixing the subject
> by adding the "rockchip:" to "ARM: dts: rockchip": :-)
>
>
> Heiko
>
>
>

-- 
Chris Zhong
