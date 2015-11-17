From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 17 Nov 2015 11:49:14 +0100
Subject: [PATCH v2] spi: mediatek: single device does not require cs_gpios
In-Reply-To: <1447468039.27169.1.camel@mhfsdcap03>
References: <1447042491-1199-1-git-send-email-drinkcat@chromium.org>
 <1447468039.27169.1.camel@mhfsdcap03>
Message-ID: <564B062A.90003@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 14/11/15 03:27, lei liu wrote:
> On Mon, 2015-11-09 at 12:14 +0800, Nicolas Boichat wrote:
>> When only one device is present, it is not necessary to specify
>> cs_gpios, as the CS line can be controlled by the hardware
>> module.
>>
>> Without this patch, older device tree bindings used before
>> 37457607 "spi: mediatek: mt8173 spi multiple devices support"
>> would cause a panic on boot. This fixes the crash, and
>> re-introduces backward compatibility.
>>
>> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
>
> Acked-by: Leilk Liu <leilk.liu@mediatek.com>
>

Please make sure this fix get applied to v4.3 as well.

Thanks,
Matthias
