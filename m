From: tony@atomide.com (Tony Lindgren)
Date: Thu, 4 Jul 2013 05:09:04 -0700
Subject: [PATCH] ARM: OMAP2+: omap2plus_defconfig: Enable appended DTB
 support
In-Reply-To: <1372684393-19025-1-git-send-email-trini@ti.com>
References: <1372684393-19025-1-git-send-email-trini@ti.com>
Message-ID: <20130704120903.GN5523@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tom Rini <trini@ti.com> [130701 06:19]:
> As this config must support boards which cannot support separate device
> trees, enable support for appended ones.

This can cause things to go wrong when DTB is not appended for mistaking the
memory as an appended DTB, especially when doing a warm reset. But as we need
this in practise for older platforms, let's add it.

Regards,

Tony
