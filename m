From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 17 Aug 2014 14:38:05 -0400
Subject: [PATCH v2] ARM: mvebu: Add RTC support for Armada 375
In-Reply-To: <1406817122-15675-1-git-send-email-gregory.clement@free-electrons.com>
References: <1406817122-15675-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140817183805.GH12769@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gregory,

On Thu, Jul 31, 2014 at 04:32:02PM +0200, Gregory CLEMENT wrote:
> The Armada 375 SoC has the same real time clock as the one used in
> other Marvell EBU platforms. This patch consequently updates the
> Device Tree of the Armada 375 SoC to describe the internal RTC.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
> Hi Jason,
> 
> We missed it for the initial support of the SoC.
> 
> I know that it is very late for including for 3.17, so if it is
> postpone for 3.18, it's fine.
> 
> However given the little change, maybe it is still possible to push it
> in 3.17 ^_^
> 
> Thanks,
> 
> Gregory
> 
> Changelog:
> 
> v1->v2:
>  - Fixed typos and improved the commit log
> 
>  arch/arm/boot/dts/armada-375.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)

Applied to mvebu/dt

thx,

Jason.
