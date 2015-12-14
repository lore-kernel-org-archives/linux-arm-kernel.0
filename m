From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 14 Dec 2015 14:05:06 +0100
Subject: [PATCH] clk: sunxi: fix handling return value of
 of_property_match_string
In-Reply-To: <1450087564-28441-3-git-send-email-a.hajda@samsung.com>
References: <1450087564-28441-1-git-send-email-a.hajda@samsung.com>
 <1450087564-28441-3-git-send-email-a.hajda@samsung.com>
Message-ID: <20151214130506.GI19456@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 14, 2015 at 11:06:00AM +0100, Andrzej Hajda wrote:
> The function can return negative values, so its result should
> be assigned to signed variable.
> 
> The problem has been detected using proposed semantic patch
> scripts/coccinelle/tests/assign_signed_to_unsigned.cocci [1].
> 
> [1]: http://permalink.gmane.org/gmane.linux.kernel/2046107
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151214/439a066f/attachment.sig>
