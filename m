From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 13 Aug 2013 15:26:14 -0400
Subject: [PATCH v4 6/6] ARM: mvebu: Fix the Armada 370/XP timer
 compatible strings
In-Reply-To: <1376404995-24548-7-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1376404995-24548-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1376404995-24548-7-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130813192614.GI25111@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 13, 2013 at 11:43:15AM -0300, Ezequiel Garcia wrote:
> The "marvell,armada-370-xp-timer" compatible string, together with
> the "marvell,timer-25Mhz" property are deprecated and should be
> removed from current DT.
> 
> Instead, the timer DT nodes are now required to have an appropriate
> compatible string, which should be either "marvell,armada-370-timer"
> or "marvell,armada-xp-timer", depending on SoC.
> 
> The clock property is now required only for Armada 370 so move it accordingly.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-370-xp.dtsi | 2 --
>  arch/arm/boot/dts/armada-370.dtsi    | 5 +++++
>  arch/arm/boot/dts/armada-xp.dtsi     | 2 +-
>  3 files changed, 6 insertions(+), 3 deletions(-)

Applied to mvebu/dt

thx,

Jason.
