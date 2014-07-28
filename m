From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 28 Jul 2014 13:14:34 +0200
Subject: [PATCH] ARM: dt: sun6i: Add #address-cells and #size-cells to
 i2c controller nodes
In-Reply-To: <16210485.QVpa35VqND@wuerfel>
References: <1405954467-29331-1-git-send-email-wens@csie.org>
 <20140728093532.GA3952@lukather> <16210485.QVpa35VqND@wuerfel>
Message-ID: <20140728111434.GE3952@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 28, 2014 at 12:21:34PM +0200, Arnd Bergmann wrote:
> On Monday 28 July 2014 11:35:32 Maxime Ripard wrote:
> > On Mon, Jul 21, 2014 at 10:54:27PM +0800, Chen-Yu Tsai wrote:
> > > dtc was giving warnings for missing #address-cells and #size-cells for
> > > the new sun6i-a31-hummingbird.dts, which has a i2c-based rtc device.
> > > 
> > > This patch adds the properties for all i2c controller nodes for sun6i.
> > > 
> > > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > 
> > Applied, thanks.
> > 
> > I don't plan on sending more DT pull-request unless something big
> > shows up, so it's probably queued for 3.18.
> > 
> > It's not like it's urgent anyway...
> > 
> 
> No, please send this one, I don't want to introduce new warnings
> in 3.17.

I didn't think we had a user for i2c yet, but yeah, we just got
one. I'll send it for 3.17 then.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140728/4790726f/attachment.sig>
