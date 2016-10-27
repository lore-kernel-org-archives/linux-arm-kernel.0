From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 27 Oct 2016 19:16:34 +0200
Subject: [linux-sunxi] [PATCH v5 2/7] ASoC: sunxi: Add a simple HDMI CODEC
In-Reply-To: <CAGb2v67cE8v3=XtTzDBst2D2U6wM8pffQYK9nEok+j4xnPT39A@mail.gmail.com>
References: <cover.1477142934.git.moinejf@free.fr>
 <5cb540f20f64d28bd7dee82a0e14ee5209631979.1477142934.git.moinejf@free.fr>
 <CAGb2v67cE8v3=XtTzDBst2D2U6wM8pffQYK9nEok+j4xnPT39A@mail.gmail.com>
Message-ID: <20161027191634.f2fa6478cd07d84a60274339@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 28 Oct 2016 00:54:34 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

> There's already a driver for basically the same thing:
> 
>     sound/soc/codec/hdmi-codec.c
> 
> You use it by registering a sub-device from your hdmi driver, with the
> proper platform_data and callbacks. Grep for HDMI_CODEC_DRV_NAME for
> platforms already using it.

I know that for a long time, and I will not use it on any account: it is
a gasworks!

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
