From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 1 Dec 2015 14:07:12 +0100
Subject: [PATCH v4 3/5] clk: sunxi: Add sun9i A80 cpus (cpu special)
 clock support
In-Reply-To: <20151130171325.GA9287@rob-hp-laptop>
References: <1448766190-11345-1-git-send-email-wens@csie.org>
 <1448766190-11345-4-git-send-email-wens@csie.org>
 <20151130171325.GA9287@rob-hp-laptop>
Message-ID: <20151201130712.GI29263@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 30, 2015 at 11:13:25AM -0600, Rob Herring wrote:
> On Sun, Nov 29, 2015 at 11:03:08AM +0800, Chen-Yu Tsai wrote:
> > The "cpus" clock is the clock for the embedded processor in the A80.
> > It is also part of the PRCM clock tree. This clock includes a pre-
> > divider on one of its inputs. For now we are using a custom clock
> > driver for it. In the future we may want to develop a generalized
> > driver for these types of clocks, which also includes the AHB clock
> > driver on sun[5678]i.
> > 
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> >  Documentation/devicetree/bindings/clock/sunxi.txt |   1 +
> 
> For the binding:
> 
> Acked-by: Rob Herring <robh@kernel.org>

Applied, thanks!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151201/e1447d5b/attachment.sig>
