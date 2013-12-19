From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 19 Dec 2013 21:02:42 +0200
Subject: [PATCHv11 07/49] clk: divider: add support for low level ops
In-Reply-To: <20131219182620.GQ27438@atomide.com>
References: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
 <1387452260-23276-8-git-send-email-t-kristo@ti.com>
 <20131219182620.GQ27438@atomide.com>
Message-ID: <52B342D2.1010301@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19/2013 08:26 PM, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [131219 03:26]:
>> Divider clock can now be registered to use low level register access ops.
>> Preferred initialization method is via clock description.
>
> This seems to make omap2 not boot for me. No output whatsoever even with
> DEBUG_LL and earlyprintk.

Thats weird... I was kind of afraid something like this might happen 
though as these patches touch the clock low level routines globally, but 
I can't see what could be broken...

-Tero
