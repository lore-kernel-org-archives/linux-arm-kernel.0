From: tony@atomide.com (Tony Lindgren)
Date: Fri, 1 Apr 2016 12:06:27 -0700
Subject: [PATCH v2] ARM: dts: dra7: Correct clock tree for sys_32k_ck
In-Reply-To: <56FEC297.50102@ti.com>
References: <1457957001-720-1-git-send-email-j-keerthy@ti.com>
 <20160330211828.GE9329@atomide.com>
 <20160330213224.GH9329@atomide.com> <56FCC3FF.7080901@ti.com>
 <56FCEC61.5020400@ti.com> <20160331170017.GI9329@atomide.com>
 <20160401153606.GJ9329@atomide.com> <56FEC297.50102@ti.com>
Message-ID: <20160401190627.GO9329@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [160401 11:50]:
> 
> Looks like a merge conflict to me, sys_32k_ck has gone under clockdomains
> for some reason. It should be under clocks.

Oh OK, I'll wait for an updated patch against v4.6-rc1 then.
Might be worth checking it applies cleanly against
omap-for-v4.6/fixes-rc1 too.

Regards,

Tony
