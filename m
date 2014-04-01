From: sdu.liu@huawei.com (Liu hua)
Date: Tue, 1 Apr 2014 11:29:05 +0800
Subject: [PATCH 0/3] add LPAE support for kexec and kernel (Liu Hua)
In-Reply-To: <1897155363.7224032.1396021473883.JavaMail.zimbra@redhat.com>
References: <mailman.28599.1395907790.1059.kexec@lists.infradead.org>
 <420609342.5318732.1395929059090.JavaMail.zimbra@redhat.com>
 <53356590.3030005@huawei.com>
 <1897155363.7224032.1396021473883.JavaMail.zimbra@redhat.com>
Message-ID: <533A3281.6080907@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2014/3/28 23:44, Dave Anderson ??:
> 
> 
> ----- Original Message -----
>> On 2014/3/27 22:04, Dave Anderson wrote:
>>>
>>>
>>> ----- Original Message -----
>>>
>>>> The patch series introduce LPAE support for user space
>>>> utility kexec(the last) and ARM linux kernel(the others).
>>>>
>>>> I have tested the patch series in armA15 platform which have
>>>> more than 4G memory.
>>>
>>> Hello Liu,
>>>
>>> I'm curious how you tested this?  The crash utility does not have
>>> any specific support for LPAE on ARM, and a couple years ago I
>>> asked on the crash-utility mailing list whether any of the ARM
>>> developers were working on it.  But at that time none of them were
>>> working with LPAE.  I see that you are on the crash-utility mailing
>>> list -- are you planning to post follow-up patches to the crash-utility?
>>>
>>> Thanks,
>>>   Dave
>>
>> Yes, you are very "sensitive"! our team has worked on it for a while. And
>> we went through the whole kdump process for LPAE enabled ARM. Our changes
>> include kexec-tools, makedumpfile, crash utility and the kernel.
>>
>> But we did that in a rather limited time. So some patches are silly and
>> need to be reconstructed before submission. In addition, my job is quit
>> full now. So I decide to post the patch series that are clear and
>> independent of the others at first.
>>
>> But I got no response from the linux-arm and kexec mailinglist. What about
>> your opinion about the feature of LPAE support for kdump related tools
>> including crash utility and the kernel?
> 
> I can't speak for the linux-arm and kexec mailing lists, but certainly 
> when you post your crash-related patches on the crash-utility mailing 
> list, I'll review, respond, and get them in place as soon as possible.
> 
> Thanks,
>   Dave

Hi Dave,

That's great. I will post crash-related patches after finishing my
work on hand, perhaps two weeks or longer. Thanks to your advice.

Thanks,
Liu Hua
