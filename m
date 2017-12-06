From: broonie@kernel.org (Mark Brown)
Date: Wed, 6 Dec 2017 15:48:10 +0000
Subject: [PATCH 4/9] ASoC: sun8i-codec: Add support for A64 SoC
In-Reply-To: <20171206153205.k3l5sofdco3t75mi@flea.lan>
References: <20171203204157.20829-1-anarsoul@gmail.com>
 <20171203204157.20829-5-anarsoul@gmail.com>
 <20171205080444.zo2rlusqpjyraqcw@flea.lan>
 <CA+E=qVdZME2fiMw09NUP4DNCYhk58dqSapCdfBjLrdMq5HFwyg@mail.gmail.com>
 <20171206153205.k3l5sofdco3t75mi@flea.lan>
Message-ID: <20171206154810.eb2czpb4kusxv5kj@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 06, 2017 at 04:32:05PM +0100, Maxime Ripard wrote:

> BCLK is sample rate * sample size * channels, and LRCK is running at
> the sample rate. So the ratio is the sample size * channels.

> Anything deviating from those standard i2s concepts should at least be
> documented, with arguments to back them off.

BCLK can be higher than the minimum there in most formats, though some
hardware is more restrictive so we tend to go for the minimum clock rate.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171206/b9d03659/attachment.sig>
