From: broonie@kernel.org (Mark Brown)
Date: Wed, 30 Sep 2015 18:33:34 +0100
Subject: [linux-sunxi] [PATCH 0/2] ASoC: Add support for the Allwinner
 A10 codec
In-Reply-To: <560AFF14.80400@redhat.com>
References: <1442064384-23379-1-git-send-email-maxime.ripard@free-electrons.com>
 <1442928417.6509.12.camel@plaes.org>
 <20150928074248.GI7104@lukather> <560AFF14.80400@redhat.com>
Message-ID: <20150930173334.GH15635@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 29, 2015 at 11:13:56PM +0200, Hans de Goede wrote:

> On both A10 and A20 I need to enable to following for things to work:

> unmute Pre-Amplifier DAC
> unmute Pre-Amplifier Mute

> I guess this is just a question if adding some mixer defaults to
> the alsa userspace somewhere ?

Yes, you're looking for something in /usr/share/alsa/cards here (shipped
in alsa-lib).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150930/657c83c6/attachment-0001.sig>
