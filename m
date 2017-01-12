From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 12 Jan 2017 18:13:45 +0100
Subject: [linux-sunxi] Re: [PATCH 2/5] clk: sunxi-ng: add support for V3s
 CCU
In-Reply-To: <20170111065524.tILSH8cS@smtp1p.mail.yandex.net>
References: <20170111065524.tILSH8cS@smtp1p.mail.yandex.net>
Message-ID: <20170112171345.nzkgg6jjyz6ywb54@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jan 11, 2017 at 11:55:16AM +0800, Icenowy Zheng wrote:
> 
> 2017?1?11? 02:10? Maxime Ripard <maxime.ripard@free-electrons.com>???
> >
> > On Tue, Jan 03, 2017 at 11:16:26PM +0800, Icenowy Zheng wrote: 
> > > V3s has a similar but cut-down CCU to H3. 
> > > 
> > > Add support for it. 
> > > 
> > > Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz> 
> >
> > It looks like there's nothing different but the clocks that you 
> > register with the H3, please just use the H3 driver. 
> 
> USB gate part is different, and many things have gone.

As far as I can see, you're only adding a few clocks, and removing a
bunch. This is definitely something that can be dealt with by simply
registering a slightly different set of clocks, like we're doing on
sun5i.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170112/32eeed87/attachment.sig>
