From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 15 Feb 2013 16:59:03 -0500
Subject: [PATCH v2 4/5] arm: mvebu: update DT to support local timers
In-Reply-To: <1359135165-32108-5-git-send-email-gregory.clement@free-electrons.com>
References: <1359135165-32108-1-git-send-email-gregory.clement@free-electrons.com>
 <1359135165-32108-5-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130215215903.GJ14746@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 25, 2013 at 06:32:44PM +0100, Gregory CLEMENT wrote:
> Now that the time-armada-370-xp support local timers, updated the
> device tree to take it into account.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-370-xp.dtsi |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Patches 4 and 5 applied to mvebu/dt with a dependency on mvebu/boards
for patches 1-3 and the previous SMP support.

thx,

Jason.
