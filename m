From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 24 Jul 2012 20:18:06 +0100
Subject: [PATCH 1/4] ASoC: mxs-saif: fix clock prepare and enable
 unbalance issue
In-Reply-To: <1342776027-31758-2-git-send-email-b29396@freescale.com>
References: <1342776027-31758-1-git-send-email-b29396@freescale.com>
 <1342776027-31758-2-git-send-email-b29396@freescale.com>
Message-ID: <20120724191806.GC3099@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 20, 2012 at 05:20:24PM +0800, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> Currently we directly call a clock_enable in trigger function without
> a clk_prepare as pair first.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120724/c3a11bca/attachment.sig>
