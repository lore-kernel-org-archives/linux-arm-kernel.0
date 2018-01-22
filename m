From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 Jan 2018 15:27:30 +0100
Subject: [PATCH v4 00/13] drm/sun4i: Support the Display Engine frontend
In-Reply-To: <cover.671c2fcad4ca649d65bd2b9982a8361befa8bfd1.1516613040.git-series.maxime.ripard@free-electrons.com>
References: <cover.671c2fcad4ca649d65bd2b9982a8361befa8bfd1.1516613040.git-series.maxime.ripard@free-electrons.com>
Message-ID: <20180122142730.lsfxdhgeetmavwpj@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 22, 2018 at 10:25:14AM +0100, Maxime Ripard wrote:
> Hi,
> 
> This is a first serie to enable the display engine frontend.
> 
> This hardware block is found in the first generation Display Engine from
> Allwinner. Its role is to implement more advanced features that the
> associated backend, even though the backend alone can be used (and was used
> so far) for basic composition.
> 
> Among those features, we will find hardware scaling, that is supported in
> this serie, colorspace conversions, or more exotic formats support such as
> the one output by the VPU.

Applied the DRM patches to drm-misc-next, and queued the dt patch for 4.17.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180122/3e48b2e1/attachment.sig>
