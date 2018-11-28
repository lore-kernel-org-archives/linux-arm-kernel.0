From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Nov 2018 11:41:25 +0100
Subject: [PATCH 07/77] ARM: dts: sun5i: Remove SoC node unit-name to
 avoid warnings
In-Reply-To: <CAGb2v65ec79rCmH=AxsSPZYj_oytuEbTZhzdJOofKYad68hANA@mail.gmail.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <003a6d6316bb1f6238556674ed162fd0b7e57456.1543321707.git-series.maxime.ripard@bootlin.com>
 <CAGb2v65ec79rCmH=AxsSPZYj_oytuEbTZhzdJOofKYad68hANA@mail.gmail.com>
Message-ID: <20181128104125.xagt4oarvzi477l7@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 11:05:30AM +0800, Chen-Yu Tsai wrote:
> On Tue, Nov 27, 2018 at 8:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > Our main node for all the in-SoC controllers used to have a unit name. The
> > unit-name, in addition to being actually false, would not match any reg
> > property, which generates a warning.
> >
> > Remove it in order to remove those warnings.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/ca0ad244/attachment-0001.sig>
