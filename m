From: rnayak@ti.com (Rajendra Nayak)
Date: Fri, 18 Jan 2013 18:58:54 +0530
Subject: [PATCH] ARM: arch_timer: Don't expect both secure and nonsecure
 PPI IRQ info
In-Reply-To: <50F94A88.1070209@arm.com>
References: <1358511830-7909-1-git-send-email-rnayak@ti.com>
 <50F94A88.1070209@arm.com>
Message-ID: <50F94E16.5080808@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 18 January 2013 06:43 PM, Marc Zyngier wrote:
> I think the real fix should be to make all the interrupts mandatory in
> the DT (they do exist in the HW), and make the code less tolerant of
> broken DTs.

Got it, thanks Mark. Time for me to go fix the OMAP5 broken DT then.
