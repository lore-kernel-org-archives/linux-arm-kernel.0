From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 4 Feb 2016 13:17:13 +0100
Subject: [PATCH 5/5] clk: sunxi: Remove clk_register_clkdev calls
In-Reply-To: <1454402834-6385-6-git-send-email-maxime.ripard@free-electrons.com>
References: <1454402834-6385-1-git-send-email-maxime.ripard@free-electrons.com>
 <1454402834-6385-6-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20160204121713.GH4270@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2016 at 09:47:14AM +0100, Maxime Ripard wrote:
> Now that our protection code doesn't use the global name lookup anymore, we
> can remove the clkdev registrations.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160204/0ddf838d/attachment.sig>
