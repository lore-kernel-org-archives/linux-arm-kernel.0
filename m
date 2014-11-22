From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 21 Nov 2014 23:12:19 -0500
Subject: [PATCH] ARM: dts: dove: add DT LCD controllers
In-Reply-To: <E1Xr3Ur-0005Qx-Fx@rmk-PC.arm.linux.org.uk>
References: <E1Xr3Ur-0005Qx-Fx@rmk-PC.arm.linux.org.uk>
Message-ID: <20141122041219.GT22670@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 19, 2014 at 11:32:29AM +0000, Russell King wrote:
> Add the DT fragment for the Marvell Dove LCD controllers.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> The documentation for this binding was submitted previously as part of
> the code which parses this - v3.17-rc1~82^2~32^2~2.
> 
>  arch/arm/boot/dts/dove.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

hmmm... this was already applied:

  087b04701111e ARM: dts: dove: add DT LCD controllers

>From here:

  https://lkml.kernel.org/r/E1XAKGS-0004WE-8h at rmk-PC.arm.linux.org.uk

thx,

Jason.
