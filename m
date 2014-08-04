From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 4 Aug 2014 13:21:05 +0200
Subject: [PATCH] clk: Add missing of_clk_set_defaults export
In-Reply-To: <1407149338-18401-1-git-send-email-s.nawrocki@samsung.com>
References: <1407149338-18401-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20140804112105.GA4379@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 04, 2014 at 12:48:58PM +0200, Sylwester Nawrocki wrote:
> The of_clk_set_defaults() function is used in subsystems which can
> be built as module. Add the missing symbol export entry so there
> is no build errors like:
> "ERROR: "of_clk_set_defaults" [drivers/i2c/i2c-core.ko] undefined!".
> 
> Fixes commit: 86be408bfbd846fab3c4ac21d6f9298bd2e4b790
> "clk: Support for clock parents and rates assigned from device tree"
> 
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

Acked-by: Wolfram Sang <wsa@the-dreams.de>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140804/e2250867/attachment-0001.sig>
