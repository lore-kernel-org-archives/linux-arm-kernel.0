From: olof@lixom.net (Olof Johansson)
Date: Sat, 12 Mar 2016 16:16:48 -0800
Subject: [PATCH v3 2/2] arm64: defconfig: Increase MMC_BLOCK_MINORS to 16
In-Reply-To: <1456397192-2407-2-git-send-email-georgi.djakov@linaro.org>
References: <1456397192-2407-1-git-send-email-georgi.djakov@linaro.org>
 <1456397192-2407-2-git-send-email-georgi.djakov@linaro.org>
Message-ID: <20160313001648.GF17502@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 25, 2016 at 12:46:32PM +0200, Georgi Djakov wrote:
> Increase the block minors from the default 8 to 16. The db410c board
> by default has eMMC rootfs on the 10th partition.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  arch/arm64/configs/defconfig |    1 +
>  1 file changed, 1 insertion(+)

Thanks, applied.


-Olof
