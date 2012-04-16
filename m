From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Apr 2012 12:54:27 -0600
Subject: arch/arm/mach-tegra/board-dt-tegra20.c: included
 asm/hardware/gic.h twice
In-Reply-To: <1329403471-32438-1-git-send-email-danny.kukawka@bisect.de>
References: <1329403471-32438-1-git-send-email-danny.kukawka@bisect.de>
Message-ID: <4F8C6AE3.7060907@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/-10/-28163 12:59 PM, Danny Kukawka wrote:
> arch/arm/mach-tegra/board-dt-tegra20.c: included 'asm/hardware/gic.h'
> twice remove the duplicates.
> 
> Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>

Applied, thanks. (with patch subject re-written)
