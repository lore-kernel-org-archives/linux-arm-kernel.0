From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 8 Nov 2014 22:38:31 -0500
Subject: [PATCH 2/2] ARM: mvebu: Remove thermal quirk for A375 Z1 revision
In-Reply-To: <1415116839-4323-3-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1415116839-4323-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1415116839-4323-3-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20141109033831.GP3698@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 04, 2014 at 01:00:39PM -0300, Ezequiel Garcia wrote:
> The Armada 375 Z1 SoC revision is no longer supported. This commit
> removes the quirk required to "fix" the reg property and the compatible
> string of the thermal devicetree node.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/board-v7.c | 66 +-----------------------------------------
>  1 file changed, 1 insertion(+), 65 deletions(-)

Applied to mvebu/soc

thx,

Jason.
