From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 25 Jan 2015 16:55:42 +0100
Subject: [PATCH 2/2] sunxi: clk: Set sun6i-pll1 n_start = 1
In-Reply-To: <1422100592-19981-2-git-send-email-hdegoede@redhat.com>
References: <1422100592-19981-1-git-send-email-hdegoede@redhat.com>
 <1422100592-19981-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20150125155542.GF8470@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 24, 2015 at 12:56:32PM +0100, Hans de Goede wrote:
> For all pll-s on sun6i n == 0 means use a multiplier of 1, rather then 0 as
> it means on sun4i / sun5i / sun7i. n_start = 1 is already correctly set
> for sun6i pll6, but was missing for pll1, this commit fixes this.
> 
> Cc: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied the two, thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150125/12cdecbe/attachment.sig>
