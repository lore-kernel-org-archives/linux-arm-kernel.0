From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 27 Jun 2018 19:04:03 +0200
Subject: [PATCH] ARM: dts: sun8i: a83t: Add CPU regulator supplies for
 A83T boards
In-Reply-To: <20180627022709.27434-1-wens@csie.org>
References: <20180627022709.27434-1-wens@csie.org>
Message-ID: <20180627170403.y7ptuiyrhklh7foj@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 27, 2018 at 10:27:09AM +0800, Chen-Yu Tsai wrote:
> The OPPs for the A83T CPU cores were added in v4.17 in commit 2db639d8c166
> ("ARM: dts: sun8i: a83t: add stable OPP tables and CPUfreq"), but board
> level regulator supplies for the CPU clusters were only added for the
> TBS-A711 tablet. This means the other A83T boards do not benefit from
> voltage scaling, or worse, if the implementation does not scale the
> frequency when the voltage is fixed, no benefit at all.
> 
> Add board level CPU cluster power supplies to all the A83T development
> boards, so they can have proper dynamic CPU voltage and frequency scaling.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180627/4a028bea/attachment.sig>
