From: daniel@caiaq.de (Daniel Mack)
Date: Thu, 26 Nov 2009 18:55:02 +0100
Subject: [PATCH 03/17] ARM: pxa/raumfeld: add SMSC9220 ethernet support
In-Reply-To: <20091125165654.GD5136@n2100.arm.linux.org.uk>
References: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
	<1259145751-3331-4-git-send-email-daniel@caiaq.de>
	<4B0D4CAC.9080403@compulab.co.il>
	<20091125154947.GP29442@buzzloop.caiaq.de>
	<20091125165654.GD5136@n2100.arm.linux.org.uk>
Message-ID: <20091126175502.GL14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2009 at 04:56:54PM +0000, Russell King - ARM Linux wrote:
> On Wed, Nov 25, 2009 at 04:49:47PM +0100, Daniel Mack wrote:
> > I had it that way, but the idea is to prevent double definitions. What
> > we have now is a config for all pins needed by the ethernet device, and
> > each machine which needs that just references it. It looks more straight
> > forward this way, but eventually that might be a matter of taste :)
> > 
> > Unless anyone has a strong opinion abouth that, I'd like to keep it as
> > it is now.
> 
> How about just having each board setup all MFP configuration at boot time
> and be done with it - yes, it'll mean some duplication for the pins which
> are common, but at least you know when looking at board N how all the pins
> are configured.

Ok, thanks. Did that now, and will repost a squashed version of the
series.

Daniel
