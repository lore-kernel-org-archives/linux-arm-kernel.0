From: olof@lixom.net (Olof Johansson)
Date: Mon, 17 Mar 2014 18:06:37 -0700
Subject: [linux-sunxi] [PATCH v4 8/8] ARM: dts: sun7i: rename clock node
 names to clk@N
In-Reply-To: <1391392304-4660-9-git-send-email-wens@csie.org>
References: <1391392304-4660-1-git-send-email-wens@csie.org>
 <1391392304-4660-9-git-send-email-wens@csie.org>
Message-ID: <CAOesGMh9sQb6ReEM==U0zKk9BqAr_e7Uh=xKAxPyrBwbiOqiKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Feb 2, 2014 at 5:51 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> Device tree naming conventions state that node names should match
> node function. Change fully functioning clock nodes to match and
> add clock-output-names to all sunxi clock nodes.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>


This patch seems to have broken cubieboard2 in arm-soc for-next. Cubie
1 is broken too, likely due to the corresponding change there.

Maxime, are we missing some dependency?


-Olof
