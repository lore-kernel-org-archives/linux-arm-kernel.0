From: broonie@kernel.org (Mark Brown)
Date: Tue, 4 Feb 2014 17:46:27 +0000
Subject: [alsa-devel] [PATCH v3 2/5] ASoC: tda998x: add a codec driver
 for the TDA998x
In-Reply-To: <52F0ECF2.9070102@metafoo.de>
References: <cover.1391274627.git.moinejf@free.fr>
 <ae68394f080f0ea5acaf3377cb1d18f29e42c646.1391274628.git.moinejf@free.fr>
 <20140204133014.GA22609@sirena.org.uk>
 <52F0ECF2.9070102@metafoo.de>
Message-ID: <20140204174627.GK22609@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 04, 2014 at 02:36:50PM +0100, Lars-Peter Clausen wrote:
> On 02/04/2014 02:30 PM, Mark Brown wrote:

> >>+static const struct snd_soc_dapm_route tda_routes[] = {
> >>+	{ "hdmi-out", NULL, "HDMI I2S Playback" },
> >>+	{ "hdmi-out", NULL, "HDMI SPDIF Playback" },
> >>+};

> >S/PDIF.

> Won't this cause issues with the debugfs widget entries? It's
> fixable by escaping it (replace it by a dash or something) in the
> debugfs widget filename, but I don't think we do this right now.

Oh, bother, so it will.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140204/bf5057df/attachment.sig>
