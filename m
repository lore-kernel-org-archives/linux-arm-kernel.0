From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 14 Jan 2015 17:39:59 +0100
Subject: [PATCH v3 07/13] ARM: dts: sunxi: Use label to reference pio in
 sunxi-common-regulators
In-Reply-To: <1421113055-17867-8-git-send-email-wens@csie.org>
References: <1421113055-17867-1-git-send-email-wens@csie.org>
 <1421113055-17867-8-git-send-email-wens@csie.org>
Message-ID: <20150114163959.GB4891@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 13, 2015 at 09:37:29AM +0800, Chen-Yu Tsai wrote:
> Use the label to reference the pin controller node, so that we can use
> sunxi-common-regulators with sunxi families that don't share the same
> address space mappings, such as sun9i.
> 
> This patch is mostly space changes due to the reduction of node parents.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150114/70e595aa/attachment.sig>
