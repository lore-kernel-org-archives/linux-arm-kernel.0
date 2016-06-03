From: olof@lixom.net (Olof Johansson)
Date: Fri, 3 Jun 2016 12:23:06 -0700
Subject: [PATCH 2/2] arm64: defconfig: Enable Cadence MACB/GEM support
In-Reply-To: <1464745199-19186-2-git-send-email-chanho.min@lge.com>
References: <1464745199-19186-1-git-send-email-chanho.min@lge.com>
 <1464745199-19186-2-git-send-email-chanho.min@lge.com>
Message-ID: <20160603192306.GF3761@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 01, 2016 at 10:39:59AM +0900, Chanho Min wrote:
> This patch enables the cadence MACB/GEM support that is needed
> by lg1k SoCs.
> 
> Signed-off-by: Chanho Min <chanho.min@lge.com>
> ---
>  arch/arm64/configs/defconfig |    1 +
>  1 file changed, 1 insertion(+)

Thanks, applied to next/arm64 for 4.8.


-Olof
