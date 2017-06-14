From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 14 Jun 2017 11:04:39 +0200
Subject: [linux-sunxi] Re: [PATCH 1/2] dmaengine: sun6i: make gate bit in
 sun8i's DMA engines a common quirk
In-Reply-To: <20170614084529.GL13020@localhost>
References: <20170605123348.26137-1-icenowy@aosc.io>
 <20170605123348.26137-2-icenowy@aosc.io>
 <20170614083252.GK13020@localhost>
 <AD656BCC-5064-454F-9576-FA59283E0C45@aosc.io>
 <20170614084529.GL13020@localhost>
Message-ID: <20170614090439.rkdaoo3uqzjqwuxq@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 14, 2017 at 02:15:29PM +0530, Vinod Koul wrote:
> > SoC info is in compatible, so there's no reason to make it a property.
> 
> that's why it would need to be optional for the SoC's that needs these..

There's nothing optional about that behaviour, it's mandatory for the
SoC that need it, and useless on the SoC that don't.

Plus, that would require changing the DT binding, which isn't
something we can do.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170614/803c9893/attachment.sig>
