From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 9 Aug 2016 20:27:11 +0200
Subject: [PATCH v2] exynos-drm: Fix unsupported GEM memory type error
 message to be clear
In-Reply-To: <1470700100-13306-1-git-send-email-shuahkh@osg.samsung.com>
References: <1470700100-13306-1-git-send-email-shuahkh@osg.samsung.com>
Message-ID: <20160809182711.GA27335@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 08, 2016 at 05:48:20PM -0600, Shuah Khan wrote:
> Fix unsupported GEM memory type error message to include the memory type
> information.
> 
> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
> ---
> Changes since v1:
> -- Comment changed to read clearly
> 
>  drivers/gpu/drm/exynos/exynos_drm_fb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>


Hi,

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
