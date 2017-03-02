From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 2 Mar 2017 15:08:59 +0100
Subject: [linux-sunxi] Re: [PATCH 2/3] clk: sunxi-ng: add support for
 PRCM CCUs
In-Reply-To: <20170301152220.MEgmqtKw@smtp2p.mail.yandex.net>
References: <20170301152220.MEgmqtKw@smtp2p.mail.yandex.net>
Message-ID: <20170302140859.aqvwtgzxkdi2lqbc@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 01, 2017 at 08:17:39PM +0800, Icenowy Zheng wrote:
> > I'm a bit worried by that to be honest. You claim to support the A31, 
> > yet jugdging by the current state of that code you never actually 
> > tested it on that SoC. 
> 
> I only claim to reserve possibility to extend the driver to support
> A31, but I didn't claim it currently support A31.

Well, you did call it sun6i.

Please rename it, and we will consolidate in due time.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170302/1a730f25/attachment.sig>
