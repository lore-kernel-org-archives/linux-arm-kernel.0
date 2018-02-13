From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 13 Feb 2018 11:30:13 +0100
Subject: [PATCH] Revert "ARM: dts: sunxi: Add regulators for Sinovoip
 BPI-M2"
In-Reply-To: <c59ee4bd3246172ec62705967bb8f751@megadrive.org>
References: <20180203112353.13497-1-icenowy@aosc.io>
 <20180205095558.2e713c24cdb7c3232943db52@bidouilliste.com>
 <207CD143-6535-42C9-BEF3-9D2614336482@aosc.io>
 <c59ee4bd3246172ec62705967bb8f751@megadrive.org>
Message-ID: <20180213103013.37q3pg6cedxur4qp@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 09, 2018 at 10:20:57PM +0100, Emmanuel Vadot wrote:
> > P.S. a proper device tree with AXP shouldn't use
> > reg_vcc3v0/3v3/1v8/etc. They're dummy
> > regulator nodes for
> > not implemented or not controllable regulators.
> > 
> > > 
> > > > This indicates that this patch should be not tested at all.
> > > 
> > > This have indeed not been tested with linux.
> > > I think that this commit should not be reverted, I'll send a proper
> > > patch tonight or tomorow night max.
> > 
> > Please test patches sent to Linux on Linux :-)
> 
>  If my patches adhere to the bindings I don't see why.

Adhering to a binding and being functional is a completely different
story.

And the latter is the most important.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180213/46d9e3cb/attachment.sig>
