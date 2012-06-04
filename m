From: rnayak@ti.com (Rajendra Nayak)
Date: Mon, 04 Jun 2012 19:34:14 +0530
Subject: [RFC 00/24] Move OMAP2+ over to use COMMON clock
In-Reply-To: <4FCCBD66.2080504@ti.com>
References: <1338552485-31325-1-git-send-email-rnayak@ti.com>
 <4FC94FC9.9070903@ti.com> <4FCC7737.8070201@ti.com> <4FCCBD66.2080504@ti.com>
Message-ID: <4FCCC05E.4090904@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 June 2012 07:21 PM, Jon Hunter wrote:
>> I was infact thinking of moving these files into mach-omap1/ since they
>> >  are now OMAP1 specific. Is your concern coming mainly from the clksel
>> >  structs that you will need to be shared across OMAP1 and OMAP2+?
> Yes, especially if we plan to move omap1 to the common clock framework.
>
>> >  The right thing to do seems like is to move OMAP1 across to COMMON clk
>> >  also and keep the plat clock.h and get rid of plat clock.c completely.
>> >  But for now, I really haven;t looked at OMAP1 migration as all.
> Yes that would make sense. Do you have plans to do this or not yet?

At-least my plan for this series was to address only OMAP2+.
