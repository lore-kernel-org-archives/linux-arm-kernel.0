From: Hiroshi.DOYU@nokia.com (Hiroshi DOYU)
Date: Mon, 10 May 2010 13:40:14 +0300 (EEST)
Subject: [PATCH 1/4] omap: mailbox: convert rwlocks to spinlock
In-Reply-To: <x2p94a0d4531005100312ocd30641ds7648e9a497e3dfd9@mail.gmail.com>
References: <1273483013-5942-1-git-send-email-Hiroshi.DOYU@nokia.com>
	<x2p94a0d4531005100312ocd30641ds7648e9a497e3dfd9@mail.gmail.com>
Message-ID: <20100510.134014.226801230.Hiroshi.DOYU@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

From: ext Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/4] omap: mailbox: convert rwlocks to spinlock
Date: Mon, 10 May 2010 12:12:52 +0200

> On Mon, May 10, 2010 at 12:16 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
>> From: Ohad Ben-Cohen <ohad@wizery.com>
>>
>> rwlocks are slower and have potential starvation issues
>> therefore spinlocks are generally preferred.
>>
>> see also: http://lwn.net/Articles/364583/
>>
>> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
>> Signed-off-by: Kanigeri Hari <h-kanigeri2@ti.com>
>> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> 
> There's no cover letter, so I'll comment here.
> 
> What about these patches?
> http://article.gmane.org/gmane.linux.ports.arm.omap/31208

OK, I'll incorporate them and send patches again.

> 
> They are needed for dspbridge... AFAIK the only real user for omap mailbox.
> 
> -- 
> Felipe Contreras
