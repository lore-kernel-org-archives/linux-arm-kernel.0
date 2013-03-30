From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 30 Mar 2013 16:38:32 -0400
Subject: [PATCH] ARM: mvebu: Add button on Armada 370 Reference Design
 board
In-Reply-To: <1363894988-3181-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1363894988-3181-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130330203832.GV13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 04:43:08PM -0300, Ezequiel Garcia wrote:
> The Marvell Armada 370 Reference Design board has a software-controlled
> button on the front side, marked as "SW".
> This patch adds minimal support for this button.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-370-rd.dts |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)

Applied to mvebu/dt

thx,

Jason.
