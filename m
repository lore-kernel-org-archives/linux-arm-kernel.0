From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 27 May 2013 16:55:57 +0200
Subject: [PATCH] clk: tegra: fix clk_out parents list
In-Reply-To: <1369641279-6894-1-git-send-email-pgaikwad@nvidia.com>
References: <1369641279-6894-1-git-send-email-pgaikwad@nvidia.com>
Message-ID: <20130527145557.GB9460@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 27, 2013 at 01:24:39PM +0530, Prashant Gaikwad wrote:
> Number of parents for clk_out_2 and clk_out_3 was incorrectly set
> to clk_out1_parents. Even though it did not break anything since the
> size was same better to fix.

This last part of the sentence is hard to understand, I think you meant:

	Even though it did not break anything since the size was the
	same, it should still be fixed.

Other than that:

Reviewed-by: Thierry Reding <thierry.reding@gmail.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130527/7121415c/attachment.sig>
