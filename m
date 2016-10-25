From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 25 Oct 2016 14:23:01 +0200
Subject: [v17 2/2] drm/bridge: Add I2C based driver for ps8640 bridge
In-Reply-To: <CAFqH_50_OwsbMWHkT_eukF52BVZYyMbGiamXO=pV4PpJq6BADA@mail.gmail.com>
References: <1472280263-18177-1-git-send-email-jitao.shi@mediatek.com>
 <1472280263-18177-2-git-send-email-jitao.shi@mediatek.com>
 <CAFqH_50_OwsbMWHkT_eukF52BVZYyMbGiamXO=pV4PpJq6BADA@mail.gmail.com>
Message-ID: <e00519e2-990c-b9b2-71d4-a4c8d36f5e65@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/18/2016 04:37 PM, Enric Balletbo Serra wrote:
[...]
>> --- /dev/null
>> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
[...]
>> +
>> +/* Firmware */
>> +#define PS_FW_NAME             "ps864x_fw.bin"
>> +
>
> From where I can download this firmware image?
>

I suppose this FW bits have to be added to linux-firmware repository 
first, before this patch can be accepted.

Regards,
Matthias
