From: olof@lixom.net (Olof Johansson)
Date: Fri, 1 Mar 2013 13:07:58 -0800
Subject: [PATCH 1/2] ARM: Tegra: Add clock entry for smp_twd clock
In-Reply-To: <1362162745-21392-1-git-send-email-swarren@wwwdotorg.org>
References: <1362162745-21392-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130301210758.GA3921@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 01, 2013 at 11:32:24AM -0700, Stephen Warren wrote:
> From: Prashant Gaikwad <pgaikwad@nvidia.com>
> 
> As DT support for clocks and smp_twd is enabled, add clock entry
> for smp_twd clock to DT.
> 
> This fixes the following error while booting the kernel:
> smp_twd: clock not found -2
> 
> Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
> [swarren: include kernel log spew that this fixes]
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> Arnd, Olof, these are fixes intended for 3.9.

Thanks, applied 1-2 to fixes.


-Olof
