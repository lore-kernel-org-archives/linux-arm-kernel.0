From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 16 Jul 2014 08:55:27 -0400
Subject: [PATCHv3 4/7] ARM: mvebu: update Armada XP DT for dynamic
 frequency scaling
In-Reply-To: <1404920715-19834-5-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1404920715-19834-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1404920715-19834-5-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140716125527.GY13108@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 09, 2014 at 05:45:12PM +0200, Thomas Petazzoni wrote:
> In order to support dynamic frequency scaling:
> 
>  * the cpuclk Device Tree node needs to be updated to describe a
>    second set of registers describing the PMU DFS registers.
> 
>  * the clock-latency property of the CPUs must be filled, otherwise
>    the ondemand and conservative cpufreq governors refuse to work. The
>    latency is high because the cost of a frequency transition is quite
>    high on those CPUs.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-xp-mv78230.dtsi | 2 ++
>  arch/arm/boot/dts/armada-xp-mv78260.dtsi | 2 ++
>  arch/arm/boot/dts/armada-xp-mv78460.dtsi | 4 ++++
>  arch/arm/boot/dts/armada-xp.dtsi         | 2 +-
>  4 files changed, 9 insertions(+), 1 deletion(-)

Applied to mvebu/dt

thx,

Jason.
