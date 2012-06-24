From: marex@denx.de (Marek Vasut)
Date: Sun, 24 Jun 2012 15:43:53 +0200
Subject: [PATCH] ARM: mx28: Add LCD pinmux
In-Reply-To: <CAOMZO5BD2N88T+0Z=tUfdo+HRdj8q0KmE=4tRX07QAb1n7s7Ng@mail.gmail.com>
References: <1340477119-2835-1-git-send-email-marex@denx.de>
 <201206241505.51551.marex@denx.de>
 <CAOMZO5BD2N88T+0Z=tUfdo+HRdj8q0KmE=4tRX07QAb1n7s7Ng@mail.gmail.com>
Message-ID: <201206241543.54209.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Fabio Estevam,

> On Sun, Jun 24, 2012 at 10:05 AM, Marek Vasut <marex@denx.de> wrote:
> > But the BPP should corelate with the number of connected data pins. Or do
> > you have any counter-argument? And besides, it's much easier to
> > understand like that.
> 
> This is not true. The pixel depth (bpp) tells how the bits are paked
> in the memory and does not correlate with the number of physically
> connected pins. For example: you can have a 16 pin LCD and decide to
> display it as 16bpp or 32bpp.
> 
> So keeping the bpp in the name of these data structure is not correct
> as you are only describing the physical connection.

Ah that's right ... makes sense now. Will respin the patch.

Best regards,
Marek Vasut
