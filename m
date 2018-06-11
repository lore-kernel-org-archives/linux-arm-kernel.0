From: tony@atomide.com (Tony Lindgren)
Date: Mon, 11 Jun 2018 00:56:29 -0700
Subject: [PATCH 2/2] ARM: dts: am437x: make edt-ft5x06 a wakeup source
 for imx6 boards
In-Reply-To: <20180611074420.GF16091@dragon>
References: <20180523083013.7570-1-daniel@zonque.org>
 <20180523083013.7570-2-daniel@zonque.org>
 <20180611074420.GF16091@dragon>
Message-ID: <20180611075629.GQ5738@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Shawn Guo <shawnguo@kernel.org> [180611 07:47]:
> On Wed, May 23, 2018 at 10:30:13AM +0200, Daniel Mack wrote:
> > The touchscreen driver no longer configures the device as wakeup source by
> > default. A "wakeup-source" property is needed.
> > 
> > Signed-off-by: Daniel Mack <daniel@zonque.org>
> 
> This is not an imx6 board, and I have to leave it to relevant platform
> maintainer.  The patch subject should be fixed to drop 'imx6'.

Daniel, can you please resend after -rc1?

Thanks,

Tony
