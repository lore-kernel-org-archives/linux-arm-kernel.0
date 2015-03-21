From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 21 Mar 2015 11:49:35 +0100
Subject: [PATCH 2/6] clk: sunxi: Add "cpu" to list of protected clocks
 for sun5i
In-Reply-To: <1426785548-5932-3-git-send-email-wens@csie.org>
References: <1426785548-5932-1-git-send-email-wens@csie.org>
 <1426785548-5932-3-git-send-email-wens@csie.org>
Message-ID: <20150321104935.GB2774@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 20, 2015 at 01:19:04AM +0800, Chen-Yu Tsai wrote:
> Now that the ahb clock on sun5i/sun7i is muxable, ahb is no longer
> guaranteed to be a child of the cpu clock. Add the cpu clock to
> the list of protected clocks so it doesn't get disabled.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150321/14e20e5c/attachment-0001.sig>
