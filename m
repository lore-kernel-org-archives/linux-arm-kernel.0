From: tj@kernel.org (Tejun Heo)
Date: Tue, 3 Dec 2013 07:42:01 -0500
Subject: [PATCH V6 2/3] ahci: imx: Pull out the clock enable/disable calls
In-Reply-To: <1385369222-5288-2-git-send-email-marex@denx.de>
References: <1385369222-5288-1-git-send-email-marex@denx.de>
 <1385369222-5288-2-git-send-email-marex@denx.de>
Message-ID: <20131203124201.GF8277@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 09:47:01AM +0100, Marek Vasut wrote:
> The same code for enabling and disabling SATA clock was found in multiple
> places in the driver. Implement functions that enable/disable the SATA clock
> and use them in such places instead of duplicating the code.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Richard Zhu <r65037@freescale.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Linux-IDE <linux-ide@vger.kernel.org>

Applied 2-3 to libata/for-3.14.

Thanks.

-- 
tejun
