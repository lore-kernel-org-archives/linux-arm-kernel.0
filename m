From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 15 Sep 2017 11:47:00 +0200
Subject: [PATCH] clk: sunxi-ng: Fix missing CLK_SET_RATE_PARENT in
 ccu-sun4i-a10.c
In-Reply-To: <CAGb2v677Ed4-iX6fkYEYZ1N9ZLKXfQQF2hhdbcbBCaB0-g174A@mail.gmail.com>
References: <20170914120519.2006-1-alex@asyring.de>
 <CAGb2v677Ed4-iX6fkYEYZ1N9ZLKXfQQF2hhdbcbBCaB0-g174A@mail.gmail.com>
Message-ID: <20170915094700.j7hykv3iq5n2iksk@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 14, 2017 at 08:14:10PM +0800, Chen-Yu Tsai wrote:
> On Thu, Sep 14, 2017 at 8:05 PM, Alexander Syring <alex@asyring.de> wrote:
> > When using cpufreq-dt with default govenor other than "performance"
> > system freezes while booting.
> > Adding CLK_SET_RATE_PARENT | CLK_IS_CRITICAL to clk_cpu fixes the
> > problem.
> >
> > Tested on Cubietruck (A20).
> >
> > Fixes: c84f5683f6E ("clk: sunxi-ng: Add sun4i/sun7i CCU driver")
> >
> > Reported-by: Alexander Syring <alex@asyring.de>
> 
> You typically don't need this if you yourself are the reporter.

Queued for 4.15.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170915/a3c00af5/attachment.sig>
