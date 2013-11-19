From: broonie@kernel.org (Mark Brown)
Date: Tue, 19 Nov 2013 18:21:00 +0000
Subject: [PATCH RFC 5/9] ASoC: hdmi-codec: Add SNDRV_PCM_FMTBIT_32_LE
 playback format
In-Reply-To: <ccbca51db46f6f38e3a1233cbdc058dbe0906bfe.1384862950.git.jsarha@ti.com>
References: <cover.1384862950.git.jsarha@ti.com>
 <ccbca51db46f6f38e3a1233cbdc058dbe0906bfe.1384862950.git.jsarha@ti.com>
Message-ID: <20131119182100.GD2674@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 19, 2013 at 02:12:25PM +0200, Jyri Sarha wrote:
> The new playback format is needed for tda998x HDMI audio support. At
> the moment the only other user of this codec is omap-hdmi-audio. This
> change should not break anything because omap-hdmi-audio-dai, the
> cpu-dai of omap-hdmi-audio, enforces sufficient constraints to
> available sample formats.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131119/9ced3eda/attachment.sig>
