From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 25 Apr 2014 20:46:07 -0400
Subject: [PATCH] ARM: mvebu: Select HAVE_ARM_TWD only if SMP is enabled
In-Reply-To: <1398339276-5754-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1398339276-5754-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20140426004607.GQ28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 24, 2014 at 08:34:36AM -0300, Ezequiel Garcia wrote:
> HAVE_ARM_TWD depends on SMP, so we should only select it if
> SMP is enabled, as the others platforms do.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to mvebu/soc

thx,

Jason.
