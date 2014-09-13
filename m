From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 13 Sep 2014 17:27:53 -0400
Subject: [PATCH 0/4] ARM: mvebu: minor Armada 370 RD improvements
In-Reply-To: <1410429419-29820-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1410429419-29820-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140913212752.GJ30828@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11, 2014 at 11:56:55AM +0200, Thomas Petazzoni wrote:
> Jason, Andrew, Gregory, Sebastian,
> 
> Here are four small patches to make minor improvements to the support
> of the Armada 370 RD platform.
> 
> Thanks,
> 
> Thomas
> 
> Thomas Petazzoni (4):
>   ARM: mvebu: add gpio fan support to Armada 370 RD
>   ARM: mvebu: add user LED support of Armada 370 RD

Applied to mvebu/dt with Andrew's Acks.

>   ARM: mvebu: add LED class support built-in in mvebu_v7_defconfig
>   ARM: mvebu: add gpio-fan to mvebu_v7_defconfig

Applied to mvebu/defconfig with Andrew's Acks.

>  arch/arm/boot/dts/armada-370-rd.dts | 32 ++++++++++++++++++++++++++++++++
>  arch/arm/configs/mvebu_v7_defconfig |  3 ++-
>  2 files changed, 34 insertions(+), 1 deletion(-)

thx,

Jason.
