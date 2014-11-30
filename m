From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 30 Nov 2014 22:29:20 +0100
Subject: [PATCH] clk: sunxi: Fix factor clocks usage for sun9i core clocks
In-Reply-To: <1417080570-5099-1-git-send-email-wens@csie.org>
References: <1417080570-5099-1-git-send-email-wens@csie.org>
Message-ID: <20141130212920.GA25249@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Nov 27, 2014 at 05:29:30PM +0800, Chen-Yu Tsai wrote:
> The sunxi factor clocks usage was changed in
> 
>     clk: sunxi: Give sunxi_factors_register a registers parameter
> 
> However the sun9i core clocks were not fixed up in that patch,
> resulting in breakage. This patch fixes that.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> Cc: Hans de Goede <hdegoede@redhat.com>

Applied, thanks!

> This patch is for 3.20.
> 
> A bit of boiler plate code for each clock provider.
> Maybe we should add a local helper or something?

Well, isn't that expected since we actually just moved it out?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141130/4bfba96a/attachment.sig>
