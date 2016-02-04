From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 4 Feb 2016 13:08:17 +0100
Subject: [PATCH 2/5] clk: sunxi: Make clocks setup functions take const
 pointer
In-Reply-To: <1454402834-6385-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1454402834-6385-1-git-send-email-maxime.ripard@free-electrons.com>
 <1454402834-6385-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20160204120817.GE4270@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2016 at 09:47:11AM +0100, Maxime Ripard wrote:
> All the data structure that we pass to the clocks setup functions are
> declared const, while our setup functions expects a regular pointer. This
> was hidden by the fact that we cast a void * pointer back to these
> structures, which made it go unnoticed.
> 
> Fix the functions prototype.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied with Andre and Chen-Yu Acked-by's

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160204/b27f5495/attachment-0001.sig>
