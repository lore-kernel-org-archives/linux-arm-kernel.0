From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 27 Aug 2013 09:20:26 -0700
Subject: linux-next: manual merge of the arm-soc tree with the usb tree
References: <20130827181353.319c150858829df1bb68d60b@canb.auug.org.au>
 <521C6961.9020103@linutronix.de>
 <CABxcv=mg6t5wPqpF3j5sr_76qfZ7N7KgpWhcKSGoPTOcaR=V6A@mail.gmail.com>
 <521CA888.1080909@baylibre.com> <521CAF59.1090203@linutronix.de>
 <521CB046.9070408@baylibre.com> <878uznxjnl.fsf@linaro.org>
 <521CC4E3.8030204@linutronix.de>
Message-ID: <87mwo3umut.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 08/27/2013 05:01 PM, Kevin Hilman wrote:
>>>> What do we do now?
>>>
>>> Cannot you just merge the stable arm-soc/dt branch into your branch
>>> before applying your patches?
>> 
>> Unfortunately, the next/dt branch of arm-soc is not necessarily stable
>> so should *not* be merged.  In fact none of the arm-soc branches should
>> be considered stable.
>> 
>> As was already mentioned, this should be split up into driver changes
>> and DTS changes through arm-soc.  They'll both merge for v3.12.
>
> But splitting will break the driver until .dts & code is in sync again.

I wouldn't lose any sleep about breaking the driver since this was not
merged properly for various reasons (as Olof has pointed out.)

Unfortunately, since it's already in Greg's stable tree, we're now left
to clean up the mess in arm-soc land [grmbl]

Kevin
