From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 24 Apr 2012 10:17:14 +0200
Subject: [PATCH] ARM pxa pcm027: use ioremap to access CPLD
In-Reply-To: <CAMPhdO-+AVHmo40tzhADLysnenbD=72hgx5U6sv09HuA9haZ2g@mail.gmail.com>
References: <1334223908-14690-1-git-send-email-s.hauer@pengutronix.de>
 <CAMPhdO-+AVHmo40tzhADLysnenbD=72hgx5U6sv09HuA9haZ2g@mail.gmail.com>
Message-ID: <20120424081714.GS3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2012 at 04:58:01PM +0800, Eric Miao wrote:
> On Thu, Apr 12, 2012 at 5:45 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > The pcm990 baseboard for the pcm027 module used to setup a static
> > mapping for accessing the CPLD. It became illegal to call iotable_init
> > that late. The pcm027 support is broken since then. This patch
> > switches the cpld support to ioremap and removes all references to
> > previous static mappings.
> >
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Looks good to me.
> 
> Acked-by: Eric Miao <eric.y.miao@gmail.com>

Thanks Eric. Who will take this patch?

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
