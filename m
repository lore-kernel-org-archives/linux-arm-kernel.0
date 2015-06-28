From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 28 Jun 2015 12:44:34 +0800
Subject: [PATCH] clocksource: imx: define clocksource for mx27
In-Reply-To: <1435439504-406-1-git-send-email-tremyfr@gmail.com>
References: <1435439504-406-1-git-send-email-tremyfr@gmail.com>
Message-ID: <20150628044434.GC10332@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 27, 2015 at 11:11:44PM +0200, Philippe Reynes wrote:
> The clocksource imx27 wasn't defined in timer-imx-gpt.c,
> so the kernel no longer boot on imx27. Just define
> clocksource imx27 as an imx21.
> 
> Signed-off-by: Philippe Reynes <tremyfr@gmail.com>

Acked-by: Shawn Guo <shawnguo@kernel.org>

Daniel,

Please help send this as a fix for 4.2-rc, thanks.

Shawn
