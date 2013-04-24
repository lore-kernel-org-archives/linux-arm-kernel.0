From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 24 Apr 2013 10:55:18 +0800
Subject: [PATCH 06/21] ARM: tegra: call cpu_do_idle from C code
In-Reply-To: <1366734653-488286-7-git-send-email-arnd@arndb.de>
References: <1366734653-488286-1-git-send-email-arnd@arndb.de>
 <1366734653-488286-7-git-send-email-arnd@arndb.de>
Message-ID: <1366772118.18275.2.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-04-24 at 00:30 +0800, Arnd Bergmann wrote:
> When building a kernel for multiple CPU architecture levels,
> cpu_do_idle() is a macro for an indirect function call, which
> cannot be called from assembly code as Tegra does.
> 
> Adding a trivial C wrapper for this function lets us build
> a tegra kernel with ARMv6 support enabled.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Joseph Lo <josephl@nvidia.com>
> Cc: Stephen Warren <swarren@nvidia.com>
> ---

Hi Arnd,

Thanks for fixing.

Tested-by: Joseph Lo <josephl@nvidia.com>

Joseph
