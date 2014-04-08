From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 8 Apr 2014 10:28:17 +0200
Subject: [PATCH v5 0/7] Add support for the Allwinner A31 DMA Controller
In-Reply-To: <1394723659-4995-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1394723659-4995-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140408082817.GA28585@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dan, Vinod,

On Thu, Mar 13, 2014 at 04:14:12PM +0100, Maxime Ripard wrote:
> Hi,
> 
> This patchset adds support for the DMA controller found in the
> Allwinner A31 and A23 SoCs.
> 
> This has been tested using the newly introduced SPI driver on an A31
> EVK. Support for DMA-driven SPI transfers will be the subject of
> another patch serie.
> 
> Thanks,
> Maxime

I first sent this patch set a month and a half ago, and since then
never had *any* comment from you. It seems like it has reached the
point where people start to be happy about it, how can we move
forward?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140408/c6d34b1a/attachment-0001.sig>
