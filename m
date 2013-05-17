From: pranavkumar@linaro.org (Pranavkumar Sawargaonkar)
Date: Fri, 17 May 2013 11:30:38 +0530
Subject: [PATCH V2 1/3] virtio: console: Add emergency writeonly register
 to config space
In-Reply-To: <871u96a3dx.fsf@rustcorp.com.au>
References: <1367842791-30285-1-git-send-email-pranavkumar@linaro.org>
 <1367842791-30285-2-git-send-email-pranavkumar@linaro.org>
 <20130516123746.GA4744@amit.redhat.com>
 <871u96a3dx.fsf@rustcorp.com.au>
Message-ID: <CAAHg+HhrvF6XxogiAA-8fzuT6byiwFUkpvr__qwTgKTxXDNdJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 May 2013 05:22, Rusty Russell <rusty@rustcorp.com.au> wrote:
> Amit Shah <amit.shah@redhat.com> writes:
>> On (Mon) 06 May 2013 [17:49:49], Pranavkumar Sawargaonkar wrote:
>>> This patch adds an emerg_wr register (writeonly) in config space
>>> of virtio console device which can be used for debugging.
>>>
>>> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
>>> Signed-off-by: Anup Patel <anup.patel@linaro.org>
>>> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
>>
>> OK, this change by itself looks harmless.
>>
>> Acked-by: Amit Shah <amit.shah@redhat.com>
>>
>>               Amit
>
> Thanks.  This is queued for *next* merge window.
>

Thanks amit and rusty.

> Cheers,
> Rusty.

Regards,
Pranav
