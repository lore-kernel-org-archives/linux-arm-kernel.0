From: olof@lixom.net (Olof Johansson)
Date: Mon, 18 Jun 2012 16:44:12 -0700
Subject: [PATCH] ARM: tegra: make tegra_cpu_reset_handler_enable() __init
In-Reply-To: <1340053310-20855-1-git-send-email-swarren@wwwdotorg.org>
References: <1340053310-20855-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20120618234412.GA2034@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2012 at 03:01:50PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> This solves a section mismatch warning. I hadn't noticed this before,
> because my compiler was inlining tegra_cpu_reset_handler_enable() inside
> tegra_cpu_reset_handler_init(), which is already __init, but I switched
> compilers and it stopped doing that.
> 
> Cc: <stable@kernel.org> # v3.4
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> Arnd, Olof, do you want me to put this in a pull request, or can you apply
> it directly for 3.5?

Single patches are just fine as is, no need for a pull request.

Applied to fixes. Thanks!


-Olof
