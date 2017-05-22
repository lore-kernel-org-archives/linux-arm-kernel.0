From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 May 2017 09:45:27 +0200
Subject: [PATCH 2/6] clk: sunxi-ng: a83t: Fix audio PLL divider offset
In-Reply-To: <CAGb2v65SUR2NvGOFFgzUpDh_9Dm6SAhzwC31KBOqFZubOhkK9w@mail.gmail.com>
References: <20170522062552.19026-1-wens@csie.org>
 <20170522062552.19026-3-wens@csie.org>
 <20170522072047.bffdbwkz2nqvhums@flea.lan>
 <CAGb2v65SUR2NvGOFFgzUpDh_9Dm6SAhzwC31KBOqFZubOhkK9w@mail.gmail.com>
Message-ID: <20170522074527.4ru2oad4neyiblnp@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 22, 2017 at 03:35:57PM +0800, Chen-Yu Tsai wrote:
> On Mon, May 22, 2017 at 3:20 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Mon, May 22, 2017 at 02:25:48PM +0800, Chen-Yu Tsai wrote:
> >> The divider of the audio PLL has an offset of 1.
> >> Fix this in the driver.
> >>
> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >
> > Applied, thanks!
> 
> So even with this patch applied, the audio is still slow and off pitch.
> It's even worse without this patch...
> 
> Maybe it's time we added a special class of clks for the audio PLL
> to deal with sigma-delta modulation of the divider?

I'm not sure how feasible that would be and what it would look like,
but you can give it a shot yes.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170522/740b2e54/attachment.sig>
