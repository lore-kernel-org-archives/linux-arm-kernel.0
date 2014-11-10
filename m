From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 10 Nov 2014 15:14:20 +0100
Subject: [PATCH 15/17] ARM: mvebu: add suspend/resume DT information for
 Armada XP GP
In-Reply-To: <1414151970-6626-16-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414151970-6626-16-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <5460C83C.8050401@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
On 24/10/2014 13:59, Thomas Petazzoni wrote:
> This commit improves the Armada XP GP Device Tree description to
> describe the 3 GPIOs that are used to connect the SoC to the PIC
> micro-controller that we talk to shutdown the SoC when entering
> suspend to RAM.
> 

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


Thanks,

Gregory

> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> 
> ---
> This probably needs some Device Tree binding documentation, but I'm
> not sure where to put it
> exactly. Documentation/devicetree/bindings/arm/armada-xp-gp-pic.txt ?
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-xp-gp.dts | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
>


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
