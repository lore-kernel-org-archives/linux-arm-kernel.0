From: tony@atomide.com (Tony Lindgren)
Date: Mon, 30 Mar 2015 16:01:17 -0700
Subject: [PATCHv5 30/35] ARM: dts: omap4: add minimal l4 bus layout with
 control module support
In-Reply-To: <1426877086-17131-31-git-send-email-t-kristo@ti.com>
References: <1426877086-17131-1-git-send-email-t-kristo@ti.com>
 <1426877086-17131-31-git-send-email-t-kristo@ti.com>
Message-ID: <20150330230116.GM10805@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Tero Kristo <t-kristo@ti.com> [150320 11:46]:
> This patch creates the l4_cfg and l4_wkup interconnects for OMAP4, and
> moves some of the generic peripherals under it. System control module
> support is added to the device tree also, and the existing SCM related
> functionality is moved under it.

Doing a diff on the dmesg output before and after this series now
produces this extra warning on omap4:

+ti_dt_clk_init_provider: scm_conf missing 'clocks' child node

Regards,

Tony
