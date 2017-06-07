From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 7 Jun 2017 11:43:43 +0200
Subject: [PATCH v2 04/11] drm: sun4i: add support for H3's TCON0/1
In-Reply-To: <493AC6F2-3CB3-48F5-9568-A34AA927238F@aosc.io>
References: <20170604160149.30230-1-icenowy@aosc.io>
 <20170604160149.30230-5-icenowy@aosc.io>
 <3642057.oKT9kIlu8M@jernej-laptop>
 <493AC6F2-3CB3-48F5-9568-A34AA927238F@aosc.io>
Message-ID: <20170607094343.qqiwnu2mhmoi6jn7@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 05, 2017 at 03:03:47AM +0800, Icenowy Zheng wrote:
> >You should also expand function sun4i_drv_node_is_tcon() at sun4i_drv.c
> >with 
> >new entries, but I'm not sure if this fits in this patch.
> 
> Instead I think it should be renamed to something like
> "sun4i_drv_node_is_tcon_with_ch0".

I'm not sure, or at least, it shouldn't make any difference, since
TCON without a channel 0 will not have an endpoint 0, so this will be
dealt with already.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170607/f3b8c14d/attachment.sig>
