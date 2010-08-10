From: Hiroshi.DOYU@nokia.com (Hiroshi DOYU)
Date: Tue, 10 Aug 2010 18:58:03 +0300 (EEST)
Subject: [PATCH] mailbox: change full flag per mailbox queue instead of
	global
In-Reply-To: <AANLkTim7s8pX3k7oF7AdZobDRegx17n5gfAze1wAduoT@mail.gmail.com>
References: <1276534269-19179-1-git-send-email-x0095840@ti.com>
	<AANLkTim7s8pX3k7oF7AdZobDRegx17n5gfAze1wAduoT@mail.gmail.com>
Message-ID: <20100810.185803.71555007.Hiroshi.DOYU@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: ext Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] mailbox: change full flag per mailbox queue instead of global
Date: Tue, 10 Aug 2010 16:36:42 +0200

> Hi Hiroshi,
> 
> On Mon, Jun 14, 2010 at 7:51 PM, Fernando Guzman Lugo <x0095840@ti.com> wrote:
>> As pointed by Ben Ohand, the variable rq_full flag is a global
>> variable, so if there are multiple mailbox users there will be
>> conflics. Now there is a full flag per mailbox queue.
>>
>> Reported-by: Ohad Ben-Cohen <ohad@wizery.com>
>> Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
> 
> It looks like this fix didn't get thru - can you please review and ack/nack ?

Sure.

Fernando, could you rebase this patch against the latest omap/master?
