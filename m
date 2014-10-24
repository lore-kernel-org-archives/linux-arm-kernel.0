From: js07.lee@gmail.com (Jungseung Lee)
Date: Fri, 24 Oct 2014 19:32:37 +0900
Subject: [PATCH 1/2] arm: hwcap: add new hwcap for identifying PXN bits
In-Reply-To: <20141024101142.GA1955@localhost>
References: <1414144655-25204-1-git-send-email-js07.lee@gmail.com>
 <20141024101142.GA1955@localhost>
Message-ID: <CAPP0e=Nt96Ej73MMMBptpqptAD-rfDg3MyOHqrGcS5sHxV-7CA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Russell and Catalin

2014-10-24 19:11 GMT+09:00 Catalin Marinas <catalin.marinas@arm.com>:
> On Fri, Oct 24, 2014 at 10:57:34AM +0100, Jungseung Lee wrote:
>> Modern ARMv7-A/R cores can optionally implement below new
>> hardware feature:
>>
>> - PXN:
>> Privileged execute-never(PXN) is a security feature. PXN bit
>> determines whether the processor can execute software from
>> the region. This is effective solution against ret2usr attack.
>>
>> This patch adds new HWCAP defines to describe new feature.
>> On an implementation that does not include the LPAE, PXN is
>> optionally supported.
>
> Why does the user need to know about such feature? Just enable it in the
> kernel if available.
>
> --
> Catalin

Yes, there is no reason to need to know.
I'll find another route to get vmsa and send patch later.

-- 
Regards,
Jungseung Lee
