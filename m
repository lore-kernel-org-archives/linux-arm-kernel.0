From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Nov 2018 14:49:07 +0100
Subject: [PATCH 35/77] ARM: dts: sun7i: Remove skeleton and memory to
 avoid warnings
In-Reply-To: <CAGb2v65oBc5PL7m_690PPo0XM18Z3ycreRBShBdwMSe6UYOGaw@mail.gmail.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <1da5c4b912ccb84e0d1873843410c6f8d282258c.1543321707.git-series.maxime.ripard@bootlin.com>
 <CAGb2v65oBc5PL7m_690PPo0XM18Z3ycreRBShBdwMSe6UYOGaw@mail.gmail.com>
Message-ID: <20181128134907.h3k4x4jtavhqrqkc@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 07:54:00PM +0800, Chen-Yu Tsai wrote:
> On Tue, Nov 27, 2018 at 8:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > Using skeleton.dtsi will create a memory node that will generate a warning
> > in DTC. However, that node will be created by the bootloader, so we can
> > just remove it entirely in order to remove that warning.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/15a0655d/attachment.sig>
