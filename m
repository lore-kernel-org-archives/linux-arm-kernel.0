From: johannes@sipsolutions.net (Johannes Berg)
Date: Fri, 17 Jan 2014 21:26:32 +0100
Subject: [PATCH RFC 0/6] net: rfkill: gpio: Add device tree support
In-Reply-To: <1389941251-32692-1-git-send-email-wens@csie.org>
References: <1389941251-32692-1-git-send-email-wens@csie.org>
Message-ID: <1389990392.10404.10.camel@jlt4.sipsolutions.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-01-17 at 14:47 +0800, Chen-Yu Tsai wrote:

> This patch series adds device tree support to rfkill-gpio, and
> fixes some issues I ran into. This is so we can define and control
> RF devices through the device tree, such as the Broadcom BCM20710
> UART-based Bluetooth device found on the CubieTruck,

> Comments, please?

Does anyone else want to maintain rfkill-gpio? :)

I'm not up to par on all the DT, ACPI and even GPIO stuff it does, and
the rfkill bits in it are really small ...

I'll happily apply the patches if everyone else is happy with them, but
please don't expect me to actually be able to say anything about them.

johannes
