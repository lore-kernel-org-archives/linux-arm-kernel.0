From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 26 Apr 2016 18:15:46 +0800
Subject: [PATCH 0/3 v2] arm64: defconfig updates
In-Reply-To: <1461167836-3163-1-git-send-email-stuart.yoder@nxp.com>
References: <1461167836-3163-1-git-send-email-stuart.yoder@nxp.com>
Message-ID: <20160426101546.GI8870@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2016 at 10:57:16AM -0500, Stuart Yoder wrote:
> Stuart Yoder (3):
>   arm64: defconfig: cleanup the defconfig
>   arm64: defconfig: enable 48-bit virtual addresses

Applied these two.

>   arm64: defconfig: enable freescale/nxp config options

But this one doesn't apply to v4.6-rc1.

Shawn

> 
>  arch/arm64/configs/defconfig | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> -- 
> 1.9.0
> 
> 
