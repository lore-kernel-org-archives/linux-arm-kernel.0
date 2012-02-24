From: lethal@linux-sh.org (Paul Mundt)
Date: Fri, 24 Feb 2012 13:31:45 +0900
Subject: [PATCH] arch/arm/mach-shmobile/board-ag5evm.c: included
 linux/dma-mapping.h twice
In-Reply-To: <1329403598-304-1-git-send-email-danny.kukawka@bisect.de>
References: <1329403598-304-1-git-send-email-danny.kukawka@bisect.de>
Message-ID: <20120224043145.GE9994@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2012 at 03:46:38PM +0100, Danny Kukawka wrote:
> arch/arm/mach-shmobile/board-ag5evm.c: included 'linux/dma-mapping.h'
> twice, remove the duplicate.
> 
> Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>

Applied, thanks.
