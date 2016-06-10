From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 10 Jun 2016 11:50:15 +0200
Subject: [PATCH 03/20] clk: sunxi: tcon-ch1: Do not return a negative
 error in get_parent
In-Reply-To: <CAGb2v64GxTFnnx40Jy9Cz9e+c+T2j2QcbFznZ4-Lm-tdHFgcXg@mail.gmail.com>
References: <1463402840-17062-1-git-send-email-maxime.ripard@free-electrons.com>
 <1463402840-17062-4-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v64GxTFnnx40Jy9Cz9e+c+T2j2QcbFznZ4-Lm-tdHFgcXg@mail.gmail.com>
Message-ID: <20160610095015.GS5242@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 17, 2016 at 12:05:18AM +0800, Chen-Yu Tsai wrote:
> On Mon, May 16, 2016 at 8:47 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > get_parent is supposed to return an unsigned 8 bit integer, so returning
> > -EINVAL is a bad idea.
> >
> > Remove it.
> >
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>

Applied,

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
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160610/7b95d042/attachment.sig>
