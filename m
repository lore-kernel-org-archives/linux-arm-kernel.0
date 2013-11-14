From: alex.shi@linaro.org (Alex Shi)
Date: Thu, 14 Nov 2013 15:46:06 +0800
Subject: a bug on NO_HZ_FULL_ALL
In-Reply-To: <52843855.5060509@linaro.org>
References: <CANHzE=2EOJmjFqLUDSfxTvgQhrUogOxH8Qux9hBFTGf8HiWWEw@mail.gmail.com>
 <52843855.5060509@linaro.org>
Message-ID: <52847FBE.9070501@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/14/2013 10:41 AM, Alex Shi wrote:
> CC to kernel mailing list.
> 
> What's you expected result for twd?

BTW, the upstream kernel has same results for twd.
> 
> 
> On 11/14/2013 08:36 AM, Shaojie Sun wrote:
>> Hi all
>>      When I enble NO_HZ_FULL and NO_HZ_FULL_ALL option in K3V2 board.
>> I find that the twd interrupt will be trigged in a large time pre
>> second.
>>      In our landing team branch, we used lsk branch.
>>
>>      Do you find this bugs on your board? And how to resolve it?
>>
>>
>>>> cat /proc/interrupts
>>
>>              CPU0     CPU1
>>  29:        293        395       GIC  twd
>>
> 
> 


-- 
Thanks
    Alex
