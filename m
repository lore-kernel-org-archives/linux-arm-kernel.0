From: lznuaa@gmail.com (Frank Li)
Date: Sun, 17 Mar 2013 09:15:52 +0800
Subject: Anyone implement Cortex A9 FIQ
In-Reply-To: <5142FBF5.3010307@arm.com>
References: <CAHrpEqSQ1n_WUfxoraKZFS2A8NjdP_MCcWmJdCjcon_QwgX4Hw@mail.gmail.com>
 <5142FBF5.3010307@arm.com>
Message-ID: <CAHrpEqSO89Lx=EGTJJ_XOFwkHqL=heoOUQCtJUzm6D7mEAbWiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/3/15 Jonathan Austin <jonathan.austin@arm.com>:
> Hi Frank,
>
>
> On 15/03/13 07:38, Frank Li wrote:
>>
>> All:
>>              Recently, we need real time work run in cortex A9.
>>              Did anyone use FIQ on Cortex A9?
>>
>
> What are you actually trying to do? There's quite a lot more complexity to
> being able to do real-time work on an A-class processor than just using FIQ,
> and much of that would be platform specific. For example on ARMv7A, we
> generally can't assume that FIQ can be used by the non-secure world...

There are period task run every 125us.
Task is quick simply, just put virtual multi DMA queue to real DMA queue.
Small memory copy and set some hardware register.


>
>
> Jonny
>
