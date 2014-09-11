From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 11 Sep 2014 15:43:23 +0200
Subject: [PATCH 0/4] ARM: mvebu: minor Armada 370 RD improvements
In-Reply-To: <1410429419-29820-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1410429419-29820-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140911134323.GB29780@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11, 2014 at 11:56:55AM +0200, Thomas Petazzoni wrote:
> Jason, Andrew, Gregory, Sebastian,
> 
> Here are four small patches to make minor improvements to the support
> of the Armada 370 RD platform.

All looks O.K. to me

Acked-by: Andrew Lunn <andrew@lunn.ch>

A point for discussion, triggered by 3/4. We have repeatedly seen
issues with modular builds, which we don't see with everything built
in. Can we improve our testing? Is there is way to take for example
mvebu_v7_defconfig and turn any y tristate options into m? Build and
boot? Get this added to the boot test farms?

      Andrew

> 
> Thanks,
> 
> Thomas
> 
> Thomas Petazzoni (4):
>   ARM: mvebu: add gpio fan support to Armada 370 RD
>   ARM: mvebu: add user LED support of Armada 370 RD
>   ARM: mvebu: add LED class support built-in in mvebu_v7_defconfig
>   ARM: mvebu: add gpio-fan to mvebu_v7_defconfig
> 
>  arch/arm/boot/dts/armada-370-rd.dts | 32 ++++++++++++++++++++++++++++++++
>  arch/arm/configs/mvebu_v7_defconfig |  3 ++-
>  2 files changed, 34 insertions(+), 1 deletion(-)
> 
> -- 
> 2.0.0
> 
