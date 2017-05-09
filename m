From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 9 May 2017 21:09:00 +0200
Subject: [PATCH v2] clk: sunxi-ng: v3s: Fix usb otg device reset bit
In-Reply-To: <a7ef1477b9dec8009e9c40bce5d42267@aosc.io>
References: <1493980317-39775-1-git-send-email-iemdey@gmail.com>
 <20170505200440.zje5s7x2seglxzi6@lukather>
 <a7ef1477b9dec8009e9c40bce5d42267@aosc.io>
Message-ID: <20170509190900.3m6fhq2mi6adc2s7@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 06, 2017 at 10:51:25PM +0800, icenowy at aosc.io wrote:
> ? 2017-05-06 04:04?Maxime Ripard ???
> > Hi,
> > 
> > On Fri, May 05, 2017 at 06:31:57PM +0800, Yong Deng wrote:
> > > V3S's usb otg device reset bit should be 24, not 23.
> > > 
> > > Signed-off-by: Yong Deng <iemdey@gmail.com>
> > > Reviewed-By: Icenowy Zheng <icenowy@aosc.io>
> > 
> > Applied, thanks.
> > Maxime
> 
> Maybe it should also apply to 4.11 stable?
> 
> Cc: stable at vger.kernel.org

I just added it, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170509/4b502c2d/attachment.sig>
