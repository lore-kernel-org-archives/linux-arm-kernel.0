From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 1 Jun 2016 13:17:30 +0200
Subject: DTS for Zynq Microzed/Picozed
In-Reply-To: <CAK7LNASao2aE-VskwsZ4DWxQSUkAHHKTgzNP9ESAgoJbUfDO-A@mail.gmail.com>
References: <CAK7LNASAe0mFD28sM=8_qDsyeGVH_wZTYyFY1uLEp85LmmSuHQ@mail.gmail.com>
 <574EB904.2070900@xilinx.com>
 <CAK7LNASao2aE-VskwsZ4DWxQSUkAHHKTgzNP9ESAgoJbUfDO-A@mail.gmail.com>
Message-ID: <574EC44A.4050009@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Masahiro,

On 1.6.2016 13:04, Masahiro Yamada wrote:
> Hi Michal.
> 
> 2016-06-01 19:29 GMT+09:00 Michal Simek <michal.simek@xilinx.com>:
>> Hi Masahiro,
>>
>>
>> On 1.6.2016 12:10, Masahiro Yamada wrote:
>>> Hi Michal,
>>>
>>>
>>> zynq-microzed.dts and zynq-picozed.dts are missing
>>> in Linux tree.
>>> (I do not see them in linux-xlnx on the GitHub, either)
>>
>> microzed and picozed board are made by Avnet not by Xilinx and none
>> pushed support for these boards.
>>
> 
> I see.
> 
> I guess Avnet boards are attractive for hobbyists
> because they are cheaper than xilinx ones.
> Supporting them would be useful I guess,
> but it is true that you have no obligation to do that.

I personally have better experience with digilent boards
(zybo for example). They just need to fix the problem with serial
console powering as is done on Xilinx boards.
But I agree Xilinx boards are pretty expensive and having cheap well
supported board will be the best option.

>>> Interestingly enough, I see both in U-Boot tree.
>>
>> Yes they are in the u-boot because IRC Nathan wanted to have support there.
>>
>>
>>> Is there some reason for that?
>>> Otherwise, do you have a plan to port them to Linux?
>>
>> I was in touch with Avnet to improve support for their reference boards
>> but there is no conclusion from that discussion.
>> I have microzed here (I don't have picozed) but I don't have any
>> immediate plan to push support for this board to Linux without any
>> support from them.
>> And pushing board without regular testing is not the right way to go.
>>
>> TBH: I am thinking to remove zynq boards which are not regularly tested.
>> For Linux this is not a problem because diff is just DTS and for U-Boot
>> with DM I believe we can be there soon.
> 
> I see.

Thanks,
Michal
