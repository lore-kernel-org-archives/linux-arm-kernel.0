From: tony@atomide.com (Tony Lindgren)
Date: Wed, 8 Aug 2012 07:24:54 -0700
Subject: [PATCH-V3] ARM: OMAP2+: cpu: Add am33xx device under
 cpu_class_is_omap2
In-Reply-To: <1344348841-19868-1-git-send-email-hvaibhav@ti.com>
References: <1344348841-19868-1-git-send-email-hvaibhav@ti.com>
Message-ID: <20120808142453.GI11011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Vaibhav Hiremath <hvaibhav@ti.com> [120807 07:15]:
> AM33XX device falls under omap2 class, so make cpu_class_is_omap2()
> macro true by adding soc_is_am33xx() to existing list of cpu/soc
> check.
> This is required to unblock the basic boot support on AM335x platform.
> 
> Having done that, we still need to sort out properly from
> common zImage point of view without having to maintain this
> cpu/soc_is_xxx list.

Thanks applying into fixes.

Tony
