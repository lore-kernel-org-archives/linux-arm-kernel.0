From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Nov 2018 11:41:15 +0100
Subject: [PATCH 06/77] ARM: dts: sun5i: Remove skeleton to avoid warnings
In-Reply-To: <CAGb2v66c-f8o=Yai_Yr02cuk976TTbpR+0oxwPnP_WUB0WPjQQ@mail.gmail.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <856695e90059a2e85dd3b0aacc9e6881967b0ccf.1543321707.git-series.maxime.ripard@bootlin.com>
 <CAGb2v66c-f8o=Yai_Yr02cuk976TTbpR+0oxwPnP_WUB0WPjQQ@mail.gmail.com>
Message-ID: <20181128104115.jle5r5tui66skawv@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 11:05:04AM +0800, Chen-Yu Tsai wrote:
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/cbb7b9a5/attachment-0001.sig>
