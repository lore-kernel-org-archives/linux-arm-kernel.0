From: tony@atomide.com (Tony Lindgren)
Date: Mon, 22 Mar 2010 18:25:18 -0700
Subject: [PATCH] arm: Fix DEBUG_LL for omap zoom2/3
In-Reply-To: <20100322212025.GW11448@atomide.com>
References: <20100320024827.GC11448@atomide.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E94026F126B9C@dbde02.ent.ti.com>
	<20100322212025.GW11448@atomide.com>
Message-ID: <20100323012518.GZ11448@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [100322 14:15]:
> 
> BTW, I'm still seeing mux errors on zoom3, have not yet
> looked into those.

Looks like we're currently missing these pins. Still need
to be checked for GPIO values and modes though, posting just
for reference as this fixes the "mux: Unknown ball offset"
on 3630.

Regards,

Tony
