From: tony@atomide.com (Tony Lindgren)
Date: Wed, 26 Sep 2018 08:59:11 -0700
Subject: [PATCH 0/4] Update am437x and am335x dts to probe with ti-sysc
In-Reply-To: <d98aa7c1-5131-34c5-51e5-c7ef57cbc31e@ti.com>
References: <20180925000545.22931-1-tony@atomide.com>
 <e9afe736-c2f0-6182-afd0-08279e09a35e@ti.com>
 <20180925144021.GN5662@atomide.com>
 <20180925175537.GQ5662@atomide.com>
 <d98aa7c1-5131-34c5-51e5-c7ef57cbc31e@ti.com>
Message-ID: <20180926155911.GT5662@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Keerthy <j-keerthy@ti.com> [180926 04:12]:
> So the below patch is solving the problem only for the first iteration
> but i see the problem recurring from second iteration of suspend.
> 
> I tried the above cycle multiple times on am437x-gp-evm. I believe
> we are one step closer still not completely fixed.

OK thanks, that's interesting, I'll take a look. Good to hear
that is the reason for pixcir issues though :)

FYI, Grygorii also pointed out that am335x gpio debounce bit
needs to be 18 not 8 for all gpio instances in am33xx-l4.dtsi.
Otherwise am335x-evm won't boot.

So I'll be posting at least one more updated test branch.

Regards,

Tony
