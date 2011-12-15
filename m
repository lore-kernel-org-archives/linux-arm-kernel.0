From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 15 Dec 2011 22:46:33 +0800
Subject: [PATCH 3/9] irq: convert generic-chip to use irq_domain
In-Reply-To: <4EE9FC99.6030905@gmail.com>
References: <1323876538-20406-1-git-send-email-robherring2@gmail.com>
 <1323876538-20406-4-git-send-email-robherring2@gmail.com>
 <20111215052512.GB21815@S2101-09.ap.freescale.net>
 <20111215055501.GC21815@S2101-09.ap.freescale.net>
 <4EE9F899.7010402@gmail.com> <4EE9FC99.6030905@gmail.com>
Message-ID: <20111215144632.GD2963@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 15, 2011 at 07:56:41AM -0600, Rob Herring wrote:
[...]
> I think I found a fix. Can you try 's/d->hwirq/(d->hwirq % 32)/' in
> generic-chip.c.
> 
Tried, it works.

-- 
Regards,
Shawn
