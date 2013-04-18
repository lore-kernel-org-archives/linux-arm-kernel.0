From: olof@lixom.net (Olof Johansson)
Date: Thu, 18 Apr 2013 09:35:02 -0700
Subject: [PATCH] ARM: tegra: pm: fix build error w/o PM_SLEEP
In-Reply-To: <1366066385-18246-1-git-send-email-swarren@wwwdotorg.org>
References: <1366066385-18246-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130418163502.GE7083@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 15, 2013 at 04:53:05PM -0600, Stephen Warren wrote:
> From: Joseph Lo <josephl@nvidia.com>
> 
> This fixes the building error when the PM_SLEEP is disabled. The fucntional
> defintion of "tegra_pm_validate_suspend_mode" without "static inline"
> would become a multiple definition error.
> 
> Reported-by: Rhyland Klein <rklein@nvidia.com>
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> Arnd, Olof, can you please apply this to arm-soc too.

Applied.


-Olof
