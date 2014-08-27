From: broonie@kernel.org (Mark Brown)
Date: Wed, 27 Aug 2014 08:40:57 +0100
Subject: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <1409078409.2701.17.camel@localhost>
References: <20140825141600.GA14763@ulmo.nvidia.com>
 <53FB46FF.1010208@redhat.com>
 <20140825145303.GC14763@ulmo.nvidia.com>
 <20140825150705.GB15297@lukather> <20140826082626.GE17263@ulmo>
 <20140826090035.GB17528@sirena.org.uk>
 <20140826091853.GI17263@ulmo>
 <20140826100612.GH17528@sirena.org.uk>
 <20140826105451.GD31124@ulmo> <1409078409.2701.17.camel@localhost>
Message-ID: <20140827074057.GS17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 08:40:09PM +0200, Henrik Nordstr?m wrote:

> It is not clear to me where the hardware resources should be listed in
> DT, being it a simplefb node or part of the actual hardware device node
> properly marked as dynamic boot defaults or something else? It's
> somewhere inbetween hardware and virtual device, and somewhat volatile.
> As far as simplefb is concerned it is a hardware desription of the
> framebuffer, but for a kms driver it's no more than firmware handover of
> boottime settings and ceases to exists once the kms driver have
> reconfigured the hardware.

Is simplefb something that should be in the device tree distinctly in
the first place - shouldn't it be a subset of the functionality of the
video nodes?  It's the same hardware being driven differently.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140827/b867ffed/attachment.sig>
