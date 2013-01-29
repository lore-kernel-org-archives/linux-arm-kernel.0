From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 29 Jan 2013 16:36:17 -0500
Subject: [PATCH v2 1/2] ARM: dove: cleanup includes
In-Reply-To: <1359494590-26005-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1355790269-10596-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1359494590-26005-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130129213617.GK7717@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 10:23:09PM +0100, Sebastian Hesselbarth wrote:
> This patch cleans unneccessary includes and reorders the remaining
> includes in common dove code.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Changelog:
> [v2]
> - restructure patches to first cleanup common.c includes [1/2]
>   and then split legacy and DT specific code [2/2]
> - removed v1 patch "[PATCH 3/3] ARM: Dove: add Cubox sdhci card
>   detect gpio" that was taken independently
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  arch/arm/mach-dove/common.c |   29 +++++++++--------------------
>  1 file changed, 9 insertions(+), 20 deletions(-)

Applied to mvebu/cleanup, thanks for turning this around so quickly.

thx,

Jason.
