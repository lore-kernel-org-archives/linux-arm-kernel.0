From: santosh.shilimkar@ti.com (Santosh)
Date: Tue, 13 Sep 2011 13:55:34 +0530
Subject: [PATCH 21/25] OMAP4: PM: Add MPUSS power domain OSWR support
In-Reply-To: <CAORVsuUaR8pcZ4MYigi85tmtWspz3tR_OJcvhaB0AFRLRaAANw@mail.gmail.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>	<1315144466-9395-22-git-send-email-santosh.shilimkar@ti.com>	<87obypfvah.fsf@ti.com>	<4E6EEC35.8080203@ti.com>
	<CAORVsuUaR8pcZ4MYigi85tmtWspz3tR_OJcvhaB0AFRLRaAANw@mail.gmail.com>
Message-ID: <4E6F137E.30105@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 September 2011 01:09 PM, Jean Pihet wrote:
> Hi Santosh,
>
> On Tue, Sep 13, 2011 at 7:37 AM, Santosh<santosh.shilimkar@ti.com>  wrote:
>> On Tuesday 13 September 2011 12:22 AM, Kevin Hilman wrote:
>>>

[..]

>>>
>>>>   static inline int omap4_finish_suspend(unsigned long cpu_state)
>>>>   {}
> This one should return 0, as I already pointed out in the comments for [14/25].
>
Taken care already.

Regards
Santosh
