From: j.uzycki@elproma.com.pl (=?UTF-8?B?SmFudXN6IFXFvHlja2k=?=)
Date: Mon, 09 Feb 2015 12:00:27 +0100
Subject: arm: kprobe compilation error
In-Reply-To: <1423475079.2864.49.camel@linaro.org>
References: <54D38982.6000100@elproma.com.pl>
 <1423475079.2864.49.camel@linaro.org>
Message-ID: <54D8934B.6040709@elproma.com.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


W dniu 2015-02-09 o 10:44, Jon Medhurst (Tixy) pisze:
> Hi Janusz
>
> On Thu, 2015-02-05 at 16:17 +0100, Janusz U?ycki wrote:
>> I got the compilation error on next-20150204:
>>
> [...]
>> In file included from arch/arm/probes/kprobes/core.c:37:
>> arch/arm/probes/kprobes/core.h:43: error: '[*]' not allowed in other
>> than a declaration
> [...]
>> gcc version 4.2.4
> Thanks for reporting this, is it OK if I add to a patch to fix this a
> line saying "Reported-by: Janusz U?ycki <j.uzycki@elproma.com.pl>"?

sure

>
> Whilst the extra '*' looks like an obvious typo, it's interesting that
> your error message implies that it's allowed in some situations and that
> the version of GCC that I use (4.9.1) doesn't complain about it.
> If it's valid C, I've no idea what that syntax that might represent.
>
I've not find such extension in C11 but likely gcc's team knows the answer.
It also compiles using gcc 4.8.3. However I thing more people use older 
compilers
for different platforms.

best regards
Janusz
