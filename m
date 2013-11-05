From: dave.long@linaro.org (David Long)
Date: Tue, 05 Nov 2013 14:55:46 -0500
Subject: [PATCH] uprobes: Export write_opcode() as uprobe_write_opcode()
In-Reply-To: <20131105190153.GA32422@redhat.com>
References: <1381871068-27660-1-git-send-email-dave.long@linaro.org>
 <1381871068-27660-2-git-send-email-dave.long@linaro.org>
 <20131105160150.GA1539@redhat.com> <20131105181614.GA7614@redhat.com>
 <20131105190153.GA32422@redhat.com>
Message-ID: <52794D42.9060306@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/13 14:01, Oleg Nesterov wrote:
> On 11/05, Oleg Nesterov wrote:
>>
>> And I think we can merge this change separately to reduce the
>> number of non-arm changes in the next version.
>
> And if you think this can help, I can push another change right
> now, see below.
>
> This way v3 will only need a single change outside of arch/arm,
> arch_uprobe_ignore(), and this change should be trivial.
>
> Oleg.
>

Yes, I agree it could only help if you merge that now instead of waiting 
for my patchset.  I have built and tested your patch in place of mine 
(on ARM) and it looks good.

-dl
