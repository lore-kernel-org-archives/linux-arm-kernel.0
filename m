From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 19 Jun 2013 10:23:55 -0700
Subject: [RFC PATCH 2/6] mfd: omap-usb-host: Put pins in IDLE state on
 suspend
In-Reply-To: <1371650753-11452-3-git-send-email-rogerq@ti.com> (Roger
 Quadros's message of "Wed, 19 Jun 2013 17:05:49 +0300")
References: <1371650753-11452-1-git-send-email-rogerq@ti.com>
 <1371650753-11452-3-git-send-email-rogerq@ti.com>
Message-ID: <878v26815g.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roger,

Roger Quadros <rogerq@ti.com> writes:

> In order to support wake up from suspend use the pinctrl
> framework to put the USB host pins in IDLE state during suspend.
>
> CC: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>

You should use helpers for this now in the pinctrl core:

    http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/173514.html

Kevin
