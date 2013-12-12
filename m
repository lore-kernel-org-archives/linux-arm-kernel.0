From: michael.opdenacker@free-electrons.com (Michael Opdenacker)
Date: Thu, 12 Dec 2013 05:51:00 +0100
Subject: [GIT PULL][for 3.14] pull request from pxa
In-Reply-To: <52A91B4B.2050907@gmail.com>
References: <52A823E4.6070208@gmail.com>
 <20131212012928.GA22922@quad.lixom.net> <52A91B4B.2050907@gmail.com>
Message-ID: <52A940B4.7090807@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2013 03:11 AM, Haojian Zhuang wrote:
> On 12/12/2013 09:29 AM, Olof Johansson wrote:
>>
>>>
>>> Michael Opdenacker (1):
>>>        ARM: pxa: remove IRQF_DISABLED
>>
>> This patch doesn't even build:
>>
>> arch/arm/mach-pxa/pcm990-baseboard.c:331:9: error: too few arguments to
>> function 'request_irq'
>>
>> Why the !@%@# are you sending me code for your platform that you didn't
>> even bother building to check for errors?
>>
>> I've fixed it up, but you really have to do better than this.
>>
>>
>> -Olof
>>
>
> I'm sorry on this. I'll be careful in the future.
>
> Best Regards
> Haojian
That's *my* fault. This patch was rather trivial and at that's why I was
confident it didn't need testing. However, I messed up on that
particular line.

My apologies!!! I'll be extra careful next time.

Michael.


-- 
Michael Opdenacker, CEO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
+33 484 258 098
