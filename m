From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 1 Dec 2015 14:10:11 +0100
Subject: [PATCH 6/7] ARM: dts: sun9i: Add Reduced Serial Bus controller
 device node to A80 dtsi
In-Reply-To: <1448948845-28347-7-git-send-email-wens@csie.org>
References: <1448948845-28347-1-git-send-email-wens@csie.org>
 <1448948845-28347-7-git-send-email-wens@csie.org>
Message-ID: <20151201131011.GO29263@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 01, 2015 at 01:47:24PM +0800, Chen-Yu Tsai wrote:
> This patch adds a device node for the Reduced Serial Bus (RSB)
> controller and the defacto pinmux setting to the A80 dtsi.
> 
> Since there is only one possible pinmux setting for RSB, just
> set it in the dtsi.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151201/cd08a5a7/attachment.sig>
