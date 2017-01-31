From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 31 Jan 2017 18:21:58 +0100
Subject: [PATCH 09/14] mtd: nand: sunxi: simplify optional reset handling
In-Reply-To: <20170130134427.14487373@bbrezillon>
References: <20170130114116.22089-1-p.zabel@pengutronix.de>
 <20170130114116.22089-9-p.zabel@pengutronix.de>
 <20170130134427.14487373@bbrezillon>
Message-ID: <1485883318.29355.2.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-01-30 at 13:44 +0100, Boris Brezillon wrote:
> Hi Philipp,
> 
> On Mon, 30 Jan 2017 12:41:11 +0100
> Philipp Zabel <p.zabel@pengutronix.de> wrote:
> 
> > As of commit bb475230b8e5 ("reset: make optional functions really
> > optional"), the reset framework API calls use NULL pointers to describe
> > optional, non-present reset controls.
> > 
> > This allows to return errors from devm_reset_control_get_optional and to
> > call reset_control_(de)assert unconditionally.
> > 
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > Cc: Icenowy Zheng <icenowy@aosc.xyz>
> > Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> > Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
> 
> I didn't find commit bb475230b8e5 in mainline, so I guess you plan to
> take this patch in your own tree. Let me know if this is not the case.
> 
> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Thanks, I plan to resend this once bb475230b8e5 hits mainline, for you
to merge.

regards
Philipp
