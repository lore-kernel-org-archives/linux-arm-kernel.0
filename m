From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 3 Mar 2017 15:48:39 +0100
Subject: [linux-sunxi] Re: [PATCH 2/3] clk: sunxi-ng: add support for
 PRCM CCUs
In-Reply-To: <3232491488467598@web22o.yandex.ru>
References: <20170301152220.MEgmqtKw@smtp2p.mail.yandex.net>
 <20170302140859.aqvwtgzxkdi2lqbc@lukather>
 <3232491488467598@web22o.yandex.ru>
Message-ID: <20170303144839.snrm5wgjyj5fvko7@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 02, 2017 at 11:13:18PM +0800, Icenowy Zheng wrote:
> 
> 
> 02.03.2017, 22:09, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
> > On Wed, Mar 01, 2017 at 08:17:39PM +0800, Icenowy Zheng wrote:
> >> ?> I'm a bit worried by that to be honest. You claim to support the A31,
> >> ?> yet jugdging by the current state of that code you never actually
> >> ?> tested it on that SoC.
> >>
> >> ?I only claim to reserve possibility to extend the driver to support
> >> ?A31, but I didn't claim it currently support A31.
> >
> > Well, you did call it sun6i.
> >
> > Please rename it, and we will consolidate in due time.
> 
> Then rename it back when it really gains support for A31?

Yes.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170303/b1f2dd6f/attachment.sig>
