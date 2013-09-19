From: broonie@kernel.org (Mark Brown)
Date: Thu, 19 Sep 2013 19:12:03 +0100
Subject: [PATCH] ASoC: generic: Add generic DT based simple codec
In-Reply-To: <20130919174952.GC12758@n2100.arm.linux.org.uk>
References: <20130919105437.75e0f0a3@armhf>
 <20130919104028.GI21013@sirena.org.uk>
 <20130919193403.30ac5764@armhf>
 <20130919174952.GC12758@n2100.arm.linux.org.uk>
Message-ID: <20130919181203.GI21013@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 19, 2013 at 06:49:52PM +0100, Russell King - ARM Linux wrote:
> On Thu, Sep 19, 2013 at 07:34:03PM +0200, Jean-Francois Moine wrote:
> > Otherwise, for Dove, we need at least "s16_le", "s24_le" and "s32_le"
> > and, perhaps, "iec958_subframe_le" and "iec958_subframe_be".

> The audio block can't do IEC958 subframes in the format ALSA wants
> them.  The hardware format is different.  I've sent a commit removing
> these foramts from sound/soc/kirkwood with a full explanation.  Mark
> seems not to have merged even that one though.

It's there in -next, it missed the merge window - there's no DAI in
mainline yet that would allow those formats anyway.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130919/1fd930e0/attachment.sig>
