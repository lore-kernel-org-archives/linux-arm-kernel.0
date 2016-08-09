From: mka@chromium.org (Matthias Kaehlcke)
Date: Mon, 8 Aug 2016 17:25:01 -0700
Subject: [PATCH v5 2/6] power: add power sequence library
In-Reply-To: <1470646331-23227-3-git-send-email-peter.chen@nxp.com>
References: <1470646331-23227-1-git-send-email-peter.chen@nxp.com>
 <1470646331-23227-3-git-send-email-peter.chen@nxp.com>
Message-ID: <20160809002501.GA125064@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El Mon, Aug 08, 2016 at 04:52:07PM +0800 Peter Chen ha dit:

> We have an well-known problem that the device needs to do some power
> sequence before it can be recognized by related host, the typical
> example like hard-wired mmc devices and usb devices.
> 
> This power sequence is hard to be described at device tree and handled by
> related host driver, so we have created a common power sequence
> library to cover this requirement. The core code has supplied
> some common helpers for host driver, and individual power sequence
> libraries handle kinds of power sequence for devices.
> 
> pwrseq_generic is intended for general purpose of power sequence, which
> handles gpios and clocks currently, and can cover regulator and pinctrl
> in future. The host driver calls pwrseq_alloc_generic to create
> an generic pwrseq instance.
> 
> Signed-off-by: Peter Chen <peter.chen@nxp.com>
> Tested-by Joshua Clayton <stillcompiling@gmail.com>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
