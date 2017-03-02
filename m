From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 2 Mar 2017 15:09:31 +0100
Subject: [PATCH 2/3] clk: sunxi-ng: add support for PRCM CCUs
In-Reply-To: <20170301152236.MUXmRgOe@smtp1m.mail.yandex.net>
References: <20170301152236.MUXmRgOe@smtp1m.mail.yandex.net>
Message-ID: <20170302140931.tq3vpncln6giyjpr@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 01, 2017 at 08:22:13PM +0800, Icenowy Zheng wrote:
> > I'm a bit worried by that to be honest. You claim to support the A31, 
> > yet jugdging by the current state of that code you never actually 
> > tested it on that SoC. 
> >
> > What makes you say that the PRCM clocks are the same for the H3 and 
> > A64? We have to be sure, otherwise we might not be able to get the DT 
> > binding right from the very beginning, and we might not be able to fix 
> > it later. 
> 
> In fact, if we worry about this, we shouldn't make r-ccu, as
> dedicated clocks are more easy to fix.
> 
> For newer SoCs' PRCM, we never have enough documents, and Allwinner
> have said that they cannot provide it. (I asked them for this.)
> 
> The best solution is to implement mature enough dedicated clocks
> before we convert to ccu.

What do you mean by dedicated clocks?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170302/08d1f681/attachment.sig>
