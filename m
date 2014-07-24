From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 24 Jul 2014 14:13:15 +0200
Subject: [PATCH v11 0/2] Add support for the Allwinner A31 DMA Controller
In-Reply-To: <1405626376-471-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1405626376-471-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140724121315.GV20328@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod, Dan,

On Thu, Jul 17, 2014 at 09:46:14PM +0200, Maxime Ripard wrote:
> Hi,
> 
> This patchset adds support for the DMA controller found in the
> Allwinner A31 and A23 SoCs.
> 
> This has been tested using the newly introduced SPI driver on an A31
> EVK. Support for DMA-driven SPI transfers will be the subject of
> another patch serie.
> 
> This has been around for around 5 monthes now, and didn't get any
> review but nitpicks for three versions, so I feel like it could be
> merged quite quickly.

Ok, so, who should I bribe to get this merged?

The first version was posted on the 2/24, we're at v11 already, and I
only got a single mail from either one of you.

Don't get me wrong, I'd be ok to make any change you deemed necessary,
but in order to do so, I at least have to get a sign of life from you,
and so far, you've both always been MIA.

We're pretty much in the same situation for the other DMA driver
Emilio has been sending for over a month now, that he is doing as part
as a GSoC for the Linux Foundation, with not a single maintainer
review so far.

I'm getting quite tired of this honestly, and I'm not sure it sends
the right message to the hobbyists and companies that try to get
things right by contributing.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140724/48ac8d0a/attachment.sig>
