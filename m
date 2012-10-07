From: olof@lixom.net (Olof Johansson)
Date: Sun, 7 Oct 2012 07:28:39 -0700
Subject: [PATCH] ARM: dts: remove redundant imx dtb targets from Makefile
In-Reply-To: <1349531385-23961-1-git-send-email-shawn.guo@linaro.org>
References: <1349531385-23961-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20121007142839.GA18045@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 06, 2012 at 09:49:45PM +0800, Shawn Guo wrote:
> We already have CONFIG_ARCH_MXC cover imx5 and imx6 dtb targets.
> Remove the redundant ones with CONFIG_ARCH_IMX5 and CONFIG_SOC_IMX6Q.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> Olof,
> 
> Most likely, it's a merge problem eventually showing on manline.
> Please send the fix for 3.7-rc.

Ah, yes, this was my fault for a bad fixup when moving targets around. Thanks
for catching it. Applied to fixes.


Regards,


-Olof
