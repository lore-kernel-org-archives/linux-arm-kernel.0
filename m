From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 7 Oct 2015 11:35:10 +0100
Subject: [PATCH v2 3/3] ARM: dts: sun6i: hummingbird: Drop AXP221 DC1SW
 and DC5LDO supplies
In-Reply-To: <1443595188-1283-4-git-send-email-wens@csie.org>
References: <1443595188-1283-1-git-send-email-wens@csie.org>
 <1443595188-1283-4-git-send-email-wens@csie.org>
Message-ID: <20151007103510.GE2278@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 30, 2015 at 02:39:47PM +0800, Chen-Yu Tsai wrote:
> "dcdc1-supply" and "dcdc5-supply" have been dropped, as they are
> internally connected and should not be represented in the device
> tree.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151007/00882231/attachment.sig>
