From: broonie@kernel.org (Mark Brown)
Date: Thu, 27 Oct 2016 19:36:17 +0100
Subject: [linux-sunxi] [PATCH v5 2/7] ASoC: sunxi: Add a simple HDMI CODEC
In-Reply-To: <20161027191634.f2fa6478cd07d84a60274339@free.fr>
References: <cover.1477142934.git.moinejf@free.fr>
 <5cb540f20f64d28bd7dee82a0e14ee5209631979.1477142934.git.moinejf@free.fr>
 <CAGb2v67cE8v3=XtTzDBst2D2U6wM8pffQYK9nEok+j4xnPT39A@mail.gmail.com>
 <20161027191634.f2fa6478cd07d84a60274339@free.fr>
Message-ID: <20161027183617.GR25322@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 27, 2016 at 07:16:34PM +0200, Jean-Francois Moine wrote:
> Chen-Yu Tsai <wens@csie.org> wrote:
> > There's already a driver for basically the same thing:

> >     sound/soc/codec/hdmi-codec.c

> > You use it by registering a sub-device from your hdmi driver, with the
> > proper platform_data and callbacks. Grep for HDMI_CODEC_DRV_NAME for
> > platforms already using it.

> I know that for a long time, and I will not use it on any account: it is
> a gasworks!

If there are problems with what's there then articulate them and fix
them, don't just open code something separate.  Just open coding
something else without any articulated reasoning is not helping things.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161027/1b274085/attachment-0001.sig>
