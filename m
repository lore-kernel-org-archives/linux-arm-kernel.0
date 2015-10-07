From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 7 Oct 2015 09:00:51 +0100
Subject: [PATCH v5 2/5] soc: sunxi: Add driver for Allwinner Reduced
 Serial Bus
In-Reply-To: <CAGb2v6693tYRFukPw-XaYVxsh9q8QHG9Z=KNs4xgeX+3UkgHWA@mail.gmail.com>
References: <1443700673-24312-1-git-send-email-wens@csie.org>
 <1443700673-24312-3-git-send-email-wens@csie.org>
 <20151004141639.GD2696@lukather>
 <CAGb2v6693tYRFukPw-XaYVxsh9q8QHG9Z=KNs4xgeX+3UkgHWA@mail.gmail.com>
Message-ID: <20151007080051.GA2278@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Oct 05, 2015 at 11:43:48PM +0800, Chen-Yu Tsai wrote:
> On Sun, Oct 4, 2015 at 10:16 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi,
> >
> > On Thu, Oct 01, 2015 at 07:57:48PM +0800, Chen-Yu Tsai wrote:
> >> Reduced Serial Bus (RSB) is an Allwinner proprietery interface
> >> used to communicate with PMICs and other peripheral ICs.
> >>
> >> RSB is a two-wire push-pull serial bus that supports 1 master
> >> device and up to 15 active slave devices.
> >>
> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >
> > Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Slightly confused. Are we merging this through your tree or directly
> through arm-soc?

I thought Arnd was the maintainer of drivers/soc, but it doesn't seem
like there's any. I'll apply your patches.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151007/eaf1e80b/attachment.sig>
