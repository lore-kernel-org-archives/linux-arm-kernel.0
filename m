From: tony@atomide.com (Tony Lindgren)
Date: Thu, 15 Aug 2013 23:58:24 -0700
Subject: [PATCH 0/2] ARM: OMAP: fix USB regression on Nokia boards
In-Reply-To: <20130815191808.GA3067@blackmetal.musicnaut.iki.fi>
References: <1375808776-14975-1-git-send-email-aaro.koskinen@iki.fi>
 <20130815191808.GA3067@blackmetal.musicnaut.iki.fi>
Message-ID: <20130816065805.GA7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [130815 12:25]:
> Hi,
> 
> On Tue, Aug 06, 2013 at 08:06:14PM +0300, Aaro Koskinen wrote:
> > USB subsystem changes broke the USB peripheral/gadget on N800, N810 and
> > RX-51/N900 during the merge window. We need to fix this in board files. I
> > tested all these with 3.11-rc4 + g_ether + ssh.
> 
> Ping?

Applying into omap-for-v3.11/fixes thanks.

Tony
