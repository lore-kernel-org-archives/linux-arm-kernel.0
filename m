From: khilman@ti.com (Kevin Hilman)
Date: Fri, 11 Feb 2011 08:37:04 -0800
Subject: [PATCH v5 0/5] omap: mailbox: hwmod support
In-Reply-To: <20110210.080134.54852186899891738.Hiroshi.DOYU@nokia.com>
	(Hiroshi DOYU's message of "Thu, 10 Feb 2011 08:01:34 +0200 (EET)")
References: <1296674843-12718-1-git-send-email-omar.ramirez@ti.com>
	<20110209183219.GA20795@atomide.com>
	<20110210.080134.54852186899891738.Hiroshi.DOYU@nokia.com>
Message-ID: <87zkq2bk9b.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hiroshi,

Hiroshi DOYU <Hiroshi.DOYU@nokia.com> writes:

> From: ext Tony Lindgren <tony@atomide.com>
> Subject: Re: [PATCH v5 0/5] omap: mailbox: hwmod support
> Date: Wed, 9 Feb 2011 10:32:19 -0800
>
>> * Omar Ramirez Luna <omar.ramirez@ti.com> [110202 11:37]:
>>> Mailbox hwmod support for OMAP 2,3,4.
>> 
>> Hiroshi, any comments on these?
>
> Well, I haven't followed hwmod much. If Kevin is ok, ok for me.

Do you have any simple standalone tests for mailbox (e.g. without
bridge/syslink) that can be used to so some sanity checking on these
driver changes?

Thanks,

Kevin
