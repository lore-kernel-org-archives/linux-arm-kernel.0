From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 7 Jun 2017 10:17:08 +0200
Subject: [PATCH] clk: sunxi-ng: Move all clock types to a library
In-Reply-To: <CAK8P3a38TyiHXBgB0DQka=0iASuyJO_zMrczXqYBiJj6LEnNWg@mail.gmail.com>
References: <20170602223006.1653-1-sboyd@codeaurora.org>
 <201706031243.qNvuUbQX%fengguang.wu@intel.com>
 <20170605144546.b6oh5sygrza22hbe@flea.lan>
 <CAK8P3a1Qvt4nvM5HeK-n87tsi2D5GBOmZo0rZv_Lp==CC=34Uw@mail.gmail.com>
 <CAGb2v66QvLdojDe4+uG9Opa7fApA-GH9pW4v0En5j6QSPf1yZw@mail.gmail.com>
 <CAK8P3a38TyiHXBgB0DQka=0iASuyJO_zMrczXqYBiJj6LEnNWg@mail.gmail.com>
Message-ID: <20170607081708.ycruditlhebizzt2@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 07, 2017 at 09:36:34AM +0200, Arnd Bergmann wrote:
> On Wed, Jun 7, 2017 at 7:45 AM, Chen-Yu Tsai <wens@csie.org> wrote:
> > at the bottom (with a comment) would be cleaner, and
> > we wouldn't need to modify all the existing lines.
> > AFAIK about Makefiles, that should work?
> 
> Ah, yes. That's much better.
> 
>       Arnd

I just applied the original patch, with that addition, and a comment
as suggested by Stephen.

thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170607/5951889e/attachment.sig>
