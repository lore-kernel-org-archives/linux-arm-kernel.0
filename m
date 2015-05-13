From: broonie@kernel.org (Mark Brown)
Date: Wed, 13 May 2015 17:47:38 +0100
Subject: [PATCH 2/4] ASoC: rockchip: add rockchip machine driver for
 max98090
In-Reply-To: <55535048.4030703@rock-chips.com>
References: <1431422797-31903-1-git-send-email-zhengxing@rock-chips.com>
 <1431422797-31903-3-git-send-email-zhengxing@rock-chips.com>
 <20150512192636.GA3066@sirena.org.uk>
 <55535048.4030703@rock-chips.com>
Message-ID: <20150513164738.GC2761@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 13, 2015 at 09:23:20PM +0800, zhengxing wrote:
> On 2015?05?13? 03:26, Mark Brown wrote:

> >This looks more like a normal and reasonable machine driver but then why
> >have you created the generic rockchip machine driver?  It seems like
> >this should just be a regular machine driver like other platforms have,
> >were it not for that this would be mostly fine apart from a couple of
> >nitpicks below.

> We just use rockchip_machine_driver to describe the supported codecs base on
> origianl way, vendor machine driver(rockchip_max98090) will achieve
> functions.

Like I said in reply to the other message I just don't understand what
you're saying here - take a look at the various Tegra machine drivers
for example, they also have per-CODEC handling but they just use normal
machine drivers to do it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150513/2a285668/attachment.sig>
