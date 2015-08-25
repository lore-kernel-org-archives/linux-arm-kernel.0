From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 25 Aug 2015 15:13:26 +0100
Subject: [PATCH v1 3/3] arm64: dts: add Hi6220 mailbox node
In-Reply-To: <20150825140450.GB28262@leoy-linaro>
References: <1439977055-1747-1-git-send-email-leo.yan@linaro.org>
 <1439977055-1747-4-git-send-email-leo.yan@linaro.org>
 <55DC532C.3020005@arm.com> <20150825140450.GB28262@leoy-linaro>
Message-ID: <55DC7806.2010003@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/08/15 15:04, Leo Yan wrote:
> Hi Sudeep,
>
> On Tue, Aug 25, 2015 at 12:36:12PM +0100, Sudeep Holla wrote:
>>
>>
>> On 19/08/15 10:37, Leo Yan wrote:
>>> On Hi6220, below memory regions in DDR have specific purpose:
>>>
>>>    0x05e0,0000 - 0x05ef,ffff: For MCU firmware using at runtime;
>>>    0x0740,f000 - 0x0740,ffff: For MCU firmware's section;
>>>    0x06df,f000 - 0x06df,ffff: For mailbox message data.
>>>
>>
>> Unless I am reading the DTS file completely wrong, I don't think the
>> above memory regions are in DDR as per the memory node.
>
> i'm not sure if understand correctly for your question; Hikey board
> has DDR 1GB at 0x0, but there have some memory regions are used for MCU.
>

Ah, I misread the address range, left the leading zero and assumed they
are not in DDR range. Sorry for the noise.

Regards,
Sudeep
