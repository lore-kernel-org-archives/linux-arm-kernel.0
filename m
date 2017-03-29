From: tony@atomide.com (Tony Lindgren)
Date: Wed, 29 Mar 2017 10:13:14 -0700
Subject: [PATCH 0/8] ARM: OMAP2+: AM33XX/AM43XX: Add suspend-resume support
In-Reply-To: <20170329015801.22240-1-d-gerlach@ti.com>
References: <20170329015801.22240-1-d-gerlach@ti.com>
Message-ID: <20170329171314.GD10760@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dave Gerlach <d-gerlach@ti.com> [170328 19:00]:
> Hi,
> This series contains the remaining code to enable suspend to mem and standby on
> am335x and am437x platforms. It depends on the ti-emif-sram series sent here [1].

Looks good to me in general. To remove the dependency, can some
of this be merged separately without breaking things before [1]?
Maybe by disabling some of the PM states until [1] is in place?

Regards,

Tony
