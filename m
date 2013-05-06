From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Tue, 7 May 2013 00:34:13 +0300
Subject: [RESEND][PATCH 1/3] arm: dts: introduce config HAS_BANDGAP
In-Reply-To: <1367874058-2378-2-git-send-email-eduardo.valentin@ti.com>
References: <1367874058-2378-1-git-send-email-eduardo.valentin@ti.com>
 <1367874058-2378-2-git-send-email-eduardo.valentin@ti.com>
Message-ID: <20130506213413.GH5634@blackmetal.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 06, 2013 at 05:00:56PM -0400, Eduardo Valentin wrote:
> Introduce HAS_BANDGAP config entry. This config is a
> boolean value so that arch code can flag is they
> feature a bandgap device.

Maybe it could be mentioned that omap-thermal already depend on this?
At least for a random reviewer it was not immediately clear why this is
added, especially since there were no users for it in subsequent patches.

A.
