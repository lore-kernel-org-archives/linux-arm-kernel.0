From: robherring2@gmail.com (Rob Herring)
Date: Mon, 20 Jan 2014 08:49:11 -0600
Subject: [PATCH] dt-bindings: add rockchip vendor prefix
In-Reply-To: <2229282.4AAJ7iLdU7@phil>
References: <201312201626.48119.heiko@sntech.de>
	<2229282.4AAJ7iLdU7@phil>
Message-ID: <CAL_JsqLwsJkCbu7rZDGTquryFzom4K4hg3GrczifbAV+pvpcaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 20, 2014 at 8:23 AM, Heiko St?bner <heiko@sntech.de> wrote:
> Am Freitag, 20. Dezember 2013, 16:26:47 schrieb Heiko St?bner:
>> It seems I forgot to add the vendor prefix for rockchip to the vendor-prefix
>> list. Therefore add it now.
>>
>> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> not sure, where this should go through
> arm-soc? or is there a special dt-tree around?

Sorry, missed this one. I'll apply for 3.14.

Rob

>
>
> Thanks
> Heiko
>
>> ---
>>  Documentation/devicetree/bindings/vendor-prefixes.txt |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt
>> b/Documentation/devicetree/bindings/vendor-prefixes.txt index
>> ca2c190..2dc3b75 100644
>> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> @@ -65,6 +65,7 @@ ralink      Mediatek/Ralink Technology Corp.
>>  ramtron      Ramtron International
>>  realtek Realtek Semiconductor Corp.
>>  renesas      Renesas Electronics Corporation
>> +rockchip     Fuzhou Rockchip Electronics Co., Ltd
>>  samsung      Samsung Semiconductor
>>  sbs  Smart Battery System
>>  schindler    Schindler
>
