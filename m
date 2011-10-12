From: olof@lixom.net (Olof Johansson)
Date: Wed, 12 Oct 2011 15:51:53 -0700
Subject: [PATCH] arm/tegra: Harmony: Configure PMC for low-level interrupts
In-Reply-To: <1316643040-7998-1-git-send-email-swarren@nvidia.com>
References: <1316643040-7998-1-git-send-email-swarren@nvidia.com>
Message-ID: <20111012225153.GA25664@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 21, 2011 at 04:10:40PM -0600, Stephen Warren wrote:
> Without this, the PMC continually detects an interrupt when the PMU_IRQ
> line is high, causing the tps6686x IRQ handler thread to hog an entire
> CPU.
> 
> This change was originally written by Wei Ni <wni@nvidia.com> for Seaboard
> in the ChromeOS kernel.
> 
> Long-term, this should probably be moved into some kind of PMU driver,
> or perhaps integrated into the GPIO/IRQ/pinmux system?
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Thanks, applied to for-3.2/features.


-Olof
