From: ralf@linux-mips.org (Ralf Baechle)
Date: Tue, 22 Sep 2015 18:29:33 +0200
Subject: [PATCH v2 3/3] FIRMWARE: bcm47xx_nvram: Use __ioread32_copy()
 instead of open-coding
In-Reply-To: <1442516531-16071-4-git-send-email-sboyd@codeaurora.org>
References: <1442516531-16071-1-git-send-email-sboyd@codeaurora.org>
 <1442516531-16071-4-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150922162932.GB16339@linux-mips.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 17, 2015 at 12:02:11PM -0700, Stephen Boyd wrote:

> Now that we have a generic library function for this, replace the
> open-coded instance.
> 
> Cc: Hauke Mehrtens <hauke@hauke-m.de>
> Cc: Rafa? Mi?ecki <zajec5@gmail.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: linux-mips at linux-mips.org
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Looking good.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
