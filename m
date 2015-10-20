From: tony@atomide.com (Tony Lindgren)
Date: Tue, 20 Oct 2015 09:21:42 -0700
Subject: [PATCH v2] ARM: dts: am437x-gp-evm: Add wakeup interrupt source
 for pixcir_i2c_ts
In-Reply-To: <1444830865-30899-1-git-send-email-vigneshr@ti.com>
References: <1444830865-30899-1-git-send-email-vigneshr@ti.com>
Message-ID: <20151020162141.GG3078@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Vignesh R <vigneshr@ti.com> [151014 06:59]:
> On am437x-gp-evm, pixcir_i2c_ts can wakeup the system from low power
> state via pinctrl and IO daisy chain using generic wakeirq framework.
> With commit 3fffd1283927 ("i2c: allow specifying separate wakeup
> interrupt in device tree") i2c core allows optional wakeirq to be
> specified via device tree. Add wakeup irq entry to enable pixcir_i2c_ts
> to wake the system from low power state.

Applying into omap-for-v4.4/dt thanks.

Tony
