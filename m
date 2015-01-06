From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 6 Jan 2015 17:07:50 +0100
Subject: [PATCH 06/17] ARM: dts: sun7i: Add cpu clock reference and
 operating points to dtsi
In-Reply-To: <1420511727-8242-7-git-send-email-wens@csie.org>
References: <1420511727-8242-1-git-send-email-wens@csie.org>
 <1420511727-8242-7-git-send-email-wens@csie.org>
Message-ID: <20150106160750.GU7853@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 06, 2015 at 10:35:16AM +0800, Chen-Yu Tsai wrote:
> The cpu core is clocked from the "cpu" clock. Add a reference to it
> in the first cpu node. Also add "cpu0" label to the node.
> 
> The operating points were taken from the A20 FEX files in the
> sunxi-boards repository. Not all boards have the same settings. The
> settings in this patch are the most generic ones.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150106/b70a5fc1/attachment.sig>
