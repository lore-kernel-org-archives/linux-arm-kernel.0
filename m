From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 29 Oct 2012 11:04:21 -0600
Subject: [PATCH 2/2] ARM: tegra: move irammap.h to mach-tegra
In-Reply-To: <1350326249-18405-2-git-send-email-swarren@wwwdotorg.org>
References: <1350326249-18405-1-git-send-email-swarren@wwwdotorg.org>
 <1350326249-18405-2-git-send-email-swarren@wwwdotorg.org>
Message-ID: <508EB715.4030101@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15/2012 12:37 PM, Stephen Warren wrote:
> Nothing outside mach-tegra uses this file, so there's no need for it to
> be in <mach/>.
> 
> Since uncompress.h and debug-macro.S remain in include/mach, they need
> to include "../../irammap.h" becaue of this change. Both these usages
> will be removed shortly, when Tegra's DEBUG_LL implementation is updated
> not to pass information through IRAM.

I have applied this to Tegra's tree for 3.8.
