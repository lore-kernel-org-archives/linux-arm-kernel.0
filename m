From: dave.long@linaro.org (David Long)
Date: Tue, 05 Nov 2013 13:45:15 -0500
Subject: [PATCH] uprobes: introduce arch_uprobe->ixol
In-Reply-To: <20131105180110.GA6943@redhat.com>
References: <1381871068-27660-1-git-send-email-dave.long@linaro.org>
 <1381871068-27660-4-git-send-email-dave.long@linaro.org>
 <20131019163627.GA7837@redhat.com> <52671265.2020107@linaro.org>
 <20131029154006.GA22344@redhat.com> <20131104194901.GA28022@redhat.com>
 <527916F4.1010805@linaro.org> <20131105180110.GA6943@redhat.com>
Message-ID: <52793CBB.5030808@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/13 13:01, Oleg Nesterov wrote:
> On 11/05, David Long wrote:
>>
>> On 11/04/13 14:49, Oleg Nesterov wrote:
>>> On 10/29, Oleg Nesterov wrote:
>>>>
>>> Seriouly, how about the patch below?
>>>
>>> In fact, given that you are going to reimplement set_swbp/orig_insn,
>>> the new member is not strictly needed (afaics). But it looks more
>>> clear this way, and we need s/MAX_UINSN_BYTES/sizeof()/ anyway.
>>>
>>> Oleg.
>>> ---
>>
>> I agree that this is cleaner than another weak callout.  I have it
>> working for ARM now.
>
> OK, I am going to add this patch to my tree, thanks. Can I add your
> acked-by ?
>
> Oleg.
>


yes.

-dl
