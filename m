From: tony@atomide.com (Tony Lindgren)
Date: Thu, 3 Dec 2015 08:37:09 -0800
Subject: [4.4-rc][PATCH] ARM: dts: am4372: disable arm twd and global
 timer's nodes
In-Reply-To: <20151203163311.GP23396@atomide.com>
References: <1447855315-419-1-git-send-email-grygorii.strashko@ti.com>
 <20151118141537.GC10644@leverpostej> <564C9ACF.6040107@ti.com>
 <20151203163311.GP23396@atomide.com>
Message-ID: <20151203163708.GR23396@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [151203 08:34]:
>
> It seems we should apply this as a fix unless somebody has better ideas.

Actually I think the fix for now is "[4.4-rc][PATCH v2] ARM: dts: am4372: fix
clock source for arm twd and global timers" until PM starts working?

Regards,

Tony
