From: xuejiancheng@hisilicon.com (Jiancheng Xue)
Date: Mon, 27 Feb 2017 09:24:34 +0800
Subject: [PATCH v2 1/2] dt-bindings: arm: hisilicon: add bindings for
 hi3798cv200 SoC and Poplar board
In-Reply-To: <ef8cca92-7f1f-40bd-4023-2e64dcf69a68@suse.de>
References: <1487752716-14824-1-git-send-email-xuejiancheng@hisilicon.com>
 <1487752716-14824-2-git-send-email-xuejiancheng@hisilicon.com>
 <ef8cca92-7f1f-40bd-4023-2e64dcf69a68@suse.de>
Message-ID: <798bfd0e-bd8d-a75d-e841-53d82b513f94@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andreas,

On 2017/2/26 9:32, Andreas F?rber wrote:
> Am 22.02.2017 um 09:38 schrieb Jiancheng Xue:
>> Add bindings for HiSilicon hi3798cv200 SoC and Poplar Board.
>>
>> Signed-off-by: Jiancheng Xue <xuejiancheng@hisilicon.com>
>> ---
>>  Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
>> index f1c1e21..1fd3dd7 100644
>> --- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
>> @@ -4,6 +4,10 @@ Hi3660 SoC
>>  Required root node properties:
>>  	- compatible = "hisilicon,hi3660";
>>  
>> +Hi3798cv200 Poplar Board
>> +Required root node properties:
>> +	- compatible = "hisilicon,hi3798cv200-poplar", "hisilicon,hi3798cv200";
> 
> Please remember to CC previous reviewers.
> 
Sorry for that.

> This still looks wrong: Why is this not "hisilicon,poplar" if you choose
> against "tocoding,poplar"? 

I didn't think it was very important thing whether the compatbile string contained
a preceding SoC name or not. I just referred to the hikey board and some other
HiSilicon boards. I wanted to keep using the same rule with them.

> Is there a second Poplar board with a different SoC? 

I can't tell about this now.

> Even then it would be redundant with the second
> compatible string.
> 
The second compatilbe string can be removed here. Thanks.

Regards,
Jiancheng

> Regards,
> Andreas
> 
>> +
>>  Hi4511 Board
>>  Required root node properties:
>>  	- compatible = "hisilicon,hi3620-hi4511";
> 
