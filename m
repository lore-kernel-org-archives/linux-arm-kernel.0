From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 1 Oct 2011 16:06:46 +0100
Subject: [PATCH v4] ARM: cache-l2x0: add resume entry for l2 in secure mode
In-Reply-To: <1317375773-7229-1-git-send-email-Barry.Song@csr.com>
References: <1317375773-7229-1-git-send-email-Barry.Song@csr.com>
Message-ID: <20111001150646.GB11710@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 30, 2011 at 02:42:53AM -0700, Barry Song wrote:
> From: Barry Song <Baohua.Song@csr.com>
> 
> we save the l2x0 registers at the first initialization, and platform codes
> can get them to restore l2x0 status after wakeup.
> 
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Tested-by: Shawn Guo <shawn.guo@linaro.org>

This looks fine, thanks Barry.

The one remaining issue is whether we use this or use Lorenzo's patches.
I feel that Barry's version is a lot simpler and easier to use, so this
is my preference.  Anyone else got another opinion between the two?
