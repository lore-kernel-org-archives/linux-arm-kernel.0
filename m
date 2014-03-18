From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 18 Mar 2014 10:25:05 +0100
Subject: [linux-sunxi] [PATCH v4 8/8] ARM: dts: sun7i: rename clock node
 names to clk@N
In-Reply-To: <CAOesGMh9sQb6ReEM==U0zKk9BqAr_e7Uh=xKAxPyrBwbiOqiKQ@mail.gmail.com>
References: <1391392304-4660-1-git-send-email-wens@csie.org>
 <1391392304-4660-9-git-send-email-wens@csie.org>
 <CAOesGMh9sQb6ReEM==U0zKk9BqAr_e7Uh=xKAxPyrBwbiOqiKQ@mail.gmail.com>
Message-ID: <20140318092505.GX27873@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Mar 17, 2014 at 06:06:37PM -0700, Olof Johansson wrote:
> Hi,
> 
> On Sun, Feb 2, 2014 at 5:51 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> > Device tree naming conventions state that node names should match
> > node function. Change fully functioning clock nodes to match and
> > add clock-output-names to all sunxi clock nodes.
> >
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> 
> 
> This patch seems to have broken cubieboard2 in arm-soc for-next. Cubie
> 1 is broken too, likely due to the corresponding change there.
> 
> Maxime, are we missing some dependency?

Most likely what you are seeing is more what Kevin already caught here:
http://lists.linaro.org/pipermail/kernel-build-reports/2014-March/002761.html

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140318/c6d0176a/attachment.sig>
