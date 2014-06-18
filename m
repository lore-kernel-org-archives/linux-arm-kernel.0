From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Wed, 18 Jun 2014 23:12:41 +0300
Subject: [PATCH] omap3-n900.dts: Rename model name to "Nokia RX-51 board"
In-Reply-To: <1403110635-29696-1-git-send-email-pali.rohar@gmail.com>
References: <1403110635-29696-1-git-send-email-pali.rohar@gmail.com>
Message-ID: <20140618201241.GB558@drone.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 18, 2014 at 06:57:15PM +0200, Pali Roh?r wrote:
> Use same name as in legacy board code. There are lot of userspace
> applications which using machine/model name for determinating device type.

Can you clarify this? Nokia kernel or userspace never had DT, so they
cannot see e.g. /proc/device-tree/model. What other APIs expose model?

A.
