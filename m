From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 9 Jan 2017 12:01:12 +0100
Subject: [linux-sunxi] Re: [PATCH 3/6] clk: sunxi-ng: Add H5 clocks
In-Reply-To: <20170106014959.nqPebrUB@smtp1p.mail.yandex.net>
References: <20170106014959.nqPebrUB@smtp1p.mail.yandex.net>
Message-ID: <20170109110112.yzmz5dcnw5lthhbm@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 06, 2017 at 06:48:31AM +0800, Icenowy Zheng wrote:
> 
> 2017?1?6? 06:04? Maxime Ripard <maxime.ripard@free-electrons.com>???
> >
> > On Tue, Dec 27, 2016 at 12:25:15AM +0800, Icenowy Zheng wrote: 
> > > Add the H5 CCU clocks set based on the H3 one. 
> > > 
> > > Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz> 
> >
> > Is there any difference with H3's? 
> 
> One more Transport Stream controller, so one more bus gate and bus
> reset for it.

There's no need to duplicate more than 1000 lines of code just for
that then. Just add a new compatible and reuse the clocks already
defined.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170109/68e7d610/attachment-0001.sig>
