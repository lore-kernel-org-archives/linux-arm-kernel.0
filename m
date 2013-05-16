From: rusty@rustcorp.com.au (Rusty Russell)
Date: Fri, 17 May 2013 09:22:58 +0930
Subject: [PATCH V2 1/3] virtio: console: Add emergency writeonly register
 to config space
In-Reply-To: <20130516123746.GA4744@amit.redhat.com>
References: <1367842791-30285-1-git-send-email-pranavkumar@linaro.org>
 <1367842791-30285-2-git-send-email-pranavkumar@linaro.org>
 <20130516123746.GA4744@amit.redhat.com>
Message-ID: <871u96a3dx.fsf@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Amit Shah <amit.shah@redhat.com> writes:
> On (Mon) 06 May 2013 [17:49:49], Pranavkumar Sawargaonkar wrote:
>> This patch adds an emerg_wr register (writeonly) in config space
>> of virtio console device which can be used for debugging.
>> 
>> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
>> Signed-off-by: Anup Patel <anup.patel@linaro.org>
>> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
>
> OK, this change by itself looks harmless.
>
> Acked-by: Amit Shah <amit.shah@redhat.com>
>
> 		Amit

Thanks.  This is queued for *next* merge window.

Cheers,
Rusty.
