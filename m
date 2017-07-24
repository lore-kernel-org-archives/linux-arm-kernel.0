From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 24 Jul 2017 11:37:26 +0200
Subject: [PATCH] clk: sunxi-ng: sun5i: Add clk_set_rate_parent to the CPU
 clock
In-Reply-To: <CAGb2v64AmFA7qHgTK6+w147-vb0Mv6uh5xx5MXy5jVfKNX_WVg@mail.gmail.com>
References: <20170721161935.18411-1-maxime.ripard@free-electrons.com>
 <CAGb2v64AmFA7qHgTK6+w147-vb0Mv6uh5xx5MXy5jVfKNX_WVg@mail.gmail.com>
Message-ID: <20170724093726.u3qpvocb7m6fujfx@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 22, 2017 at 10:23:19AM +0800, Chen-Yu Tsai wrote:
> On Sat, Jul 22, 2017 at 12:19 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The current CPU clock is missing the option to change the rate of its
> > parents, leading to improper rates calculated by cpufreq, and eventually
> > crashes.
> >
> > Cc: <stable@vger.kernel.org>
> > Fixes: 5e73761786d6 ("clk: sunxi-ng: Add sun5i CCU driver")
> > Reported-by: Kevin Hilman <khilman@baylibre.com>
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>

Applied as a fix, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170724/c1e72a42/attachment.sig>
