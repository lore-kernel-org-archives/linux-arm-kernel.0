From: maxime.chevallier@bootlin.com (Maxime Chevallier)
Date: Wed, 25 Apr 2018 13:52:36 +0200
Subject: [PATCH net 2/3] net: mvpp2: Fix clock resource by adding
 missing mg_core_clk
In-Reply-To: <87in8feckt.fsf@bootlin.com>
References: <20180425110731.20153-1-maxime.chevallier@bootlin.com>
 <20180425110731.20153-3-maxime.chevallier@bootlin.com>
 <87in8feckt.fsf@bootlin.com>
Message-ID: <20180425135236.24bc0644@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On Wed, 25 Apr 2018 13:43:14 +0200
Gregory CLEMENT <gregory.clement@bootlin.com> wrote:

>Hi Maxime,
> 
> On mer., avril 25 2018, Maxime Chevallier
> <maxime.chevallier@bootlin.com> wrote:
>
>> Marvell's PPv2.2 IP needs an additional clock named "MG Core clock".
>> This is required on Armada 7K and 8K.
>>
>> This commit adds the required clock, updates the devicetree and its
>> documentation accordingly, also fixing a small typo in the
>> marvell-mpp2.txt examples.
>>
>> Fixes: c7e92def1ef4 ("clk: mvebu: cp110: Fix clock tree
>> representation") Signed-off-by: Maxime Chevallier
>> <maxime.chevallier@bootlin.com> ---
>>  .../devicetree/bindings/net/marvell-pp2.txt          |  9 +++++----
>>  arch/arm64/boot/dts/marvell/armada-cp110.dtsi        |  5 +++--  
>
>Could you remove the dtsi part and submit it as a separate patch. Then
>I will take care of it.

Ok no problem, I'll split that and re-send it.

Thanks,

Maxime

-- 
Maxime Chevallier, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
