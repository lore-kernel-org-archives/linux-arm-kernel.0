From: balbi@ti.com (Felipe Balbi)
Date: Mon, 17 Dec 2012 20:08:52 +0200
Subject: [GIT PULL] omap fixes and cleanups for v3.8 merge window
In-Reply-To: <20121217180200.GU4989@atomide.com>
References: <20121217180200.GU4989@atomide.com>
Message-ID: <20121217180852.GA24440@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 17, 2012 at 10:02:01AM -0800, Tony Lindgren wrote:
>  drivers/mfd/omap-usb-host.c                        |  3 +-
>  drivers/tty/serial/omap-serial.c                   |  3 +-
>  drivers/usb/phy/Kconfig                            |  1 +

I did mention I was against adding OMAP dependencies do drivers.
Interesting to see to commit going upstream without a reply to my
comment :-s

http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap.git;a=commitdiff;h=3e194c88f8b71700822828749187e65853ed8166

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121217/9724bddc/attachment.sig>
