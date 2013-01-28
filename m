From: olof@lixom.net (Olof Johansson)
Date: Mon, 28 Jan 2013 14:00:26 -0800
Subject: [GIT PULL] imx cleanup for 3.9
In-Reply-To: <20130122144813.GD2812@S2101-09.ap.freescale.net>
References: <20130122144813.GD2812@S2101-09.ap.freescale.net>
Message-ID: <20130128220026.GC3047@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 22, 2013 at 10:48:15PM +0800, Shawn Guo wrote:

> Shawn Guo (4):
>       ARM: dts: imx: use nodes label in board dts

Hmm.

This patch is 1000 lines of pure churn. Sure, the style on OMAP is different,
but there's no clear benefit from it -- it's actually advantageous to see some
of the bus hierarchies even on the leaf-level board nodes.

Would you mind respinning with this left out, please? If you still want to
argue it to be included, we can do so, but I'd like to pick up the rest of the
branch meanwhile. :-)


Thanks!

-Olof
