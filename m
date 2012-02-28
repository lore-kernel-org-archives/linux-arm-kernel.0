From: tony@atomide.com (Tony Lindgren)
Date: Tue, 28 Feb 2012 15:57:06 -0800
Subject: [PATCH] ARM: OMAP2+: Remove apply_uV constraints for fixed
 regulator
In-Reply-To: <1330421554-29369-1-git-send-email-rnayak@ti.com>
References: <1330421554-29369-1-git-send-email-rnayak@ti.com>
Message-ID: <20120228235706.GJ18901@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rajendra Nayak <rnayak@ti.com> [120228 01:01]:
> VUSB is a fixed regulator, so get rid of the apply_uV constraint
> for it, which fixes the following error seen at boot on omap4
> SDP and PANDA boards.
> 
> machine_constraints_voltage: VUSB: failed to apply 3300000uV constraint
> twl_reg twl_reg.46: can't register VUSB, -22
> twl_reg: probe of twl_reg.46 failed with error -22

Thanks applying into fixes.

Tony
