From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 30 Dec 2013 13:20:00 -0800
Subject: [PATCH v2 6/7] drm/msm: Drop unnecessary mach include
In-Reply-To: <1388438133-431-7-git-send-email-sboyd@codeaurora.org>
References: <1388438133-431-1-git-send-email-sboyd@codeaurora.org>
 <1388438133-431-7-git-send-email-sboyd@codeaurora.org>
Message-ID: <52C1E380.4060307@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/30/13 13:15, Stephen Boyd wrote:
> This file doesn't use the clk_reset() API that is exposed in
> mach-msm's mach/clk.h file. Remove the include so that this
> driver can be compiled as part of the multi-platform kernel.
>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Dave Airlie <airlied@redhat.com>

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

> ---
>  drivers/gpu/drm/msm/mdp4/mdp4_dtv_encoder.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/mdp4/mdp4_dtv_encoder.c b/drivers/gpu/drm/msm/mdp4/mdp4_dtv_encoder.c
> index 5e0dcae..3799ccc 100644
> --- a/drivers/gpu/drm/msm/mdp4/mdp4_dtv_encoder.c
> +++ b/drivers/gpu/drm/msm/mdp4/mdp4_dtv_encoder.c
> @@ -15,8 +15,6 @@
>   * this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>  
> -#include <mach/clk.h>
> -
>  #include "mdp4_kms.h"
>  
>  #include "drm_crtc.h"


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
