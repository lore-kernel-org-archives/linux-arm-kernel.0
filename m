From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Tue, 27 Jun 2017 13:22:58 -0700
Subject: [PATCH 1/2] RFC: ARM: dts: imx7d-sdb: remove 100k pull-down on
 USDHCx clock
In-Reply-To: <AM3PR04MB306F527858F26C0F686617880DC0@AM3PR04MB306.eurprd04.prod.outlook.com>
References: <1496857542-32200-1-git-send-email-troy.kisky@boundarydevices.com>
 <20170615033851.GA5902@dragon>
 <AM3PR04MB306DAC69AE94A872373206280C00@AM3PR04MB306.eurprd04.prod.outlook.com>
 <c69c5ffb-1142-74fa-4be4-1112c49ae67c@boundarydevices.com>
 <AM3PR04MB306F527858F26C0F686617880DC0@AM3PR04MB306.eurprd04.prod.outlook.com>
Message-ID: <26958bc9-7598-74d7-7a4b-91638bf1971c@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/26/2017 10:32 PM, A.s. Dong wrote:
> Hi Troy,
> 
>> -----Original Message-----
>> From: Troy Kisky [mailto:troy.kisky at boundarydevices.com]
>> Sent: Friday, June 16, 2017 1:46 AM
>> To: A.s. Dong; Shawn Guo; Frank Li
>> Cc: shawn.guo at linaro.org; Fabio Estevam; gary.bisson at boundarydevices.com;
>> linux-arm-kernel at lists.infradead.org
>> Subject: Re: [PATCH 1/2] RFC: ARM: dts: imx7d-sdb: remove 100k pull-down
>> on USDHCx clock
>>
>> On 6/14/2017 9:31 PM, A.s. Dong wrote:
>>> Hi Troy,
>>>
>>>> -----Original Message-----
>>>> From: Shawn Guo [mailto:shawnguo at kernel.org]
>>>> Sent: Thursday, June 15, 2017 11:39 AM
>>>> To: Troy Kisky; A.s. Dong; Frank Li
>>>> Cc: shawn.guo at linaro.org; Fabio Estevam;
>>>> gary.bisson at boundarydevices.com; linux-arm-kernel at lists.infradead.org
>>>> Subject: Re: [PATCH 1/2] RFC: ARM: dts: imx7d-sdb: remove 100k
>>>> pull-down on USDHCx clock
>>>>
>>>> On Wed, Jun 07, 2017 at 10:45:41AM -0700, Troy Kisky wrote:
>>>>> No i.mx6q board uses a 100k pull-down on clock, why should i.mx7d ?
>>>>>
>>>
>>> I saw the mx7d evk clk resistor pull-down is DNP, then why we disable
>>> internal pad pull-down?
>>
>>
>> That sounds like a very good reason to disable to me.
>> Why rely on a DNP? Also, consistency with imx6 is nice.
>>
> 
> Sorry missed your reply.
> 
> Not quite understand your point.
> We would like to pull down the clk signal in default state,
> But due to the board pull-down resistor is DNP (not exist),
> That's why we use internal pull down function instead.
> 
> Regards
> Dong Aisheng
> 


I totally misinterpreted what you said about the DNP. Sorry.
I understand you now, thanks.

But can you say why you want to pull down the clk signal in default state ?
And why mx6q does not want to do the same ?


Thanks
Troy
