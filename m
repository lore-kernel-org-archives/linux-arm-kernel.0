From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 28 May 2015 10:49:39 +0200
Subject: [PATCH 3/3] bus: mvebu-mbus: add mv_mbus_dram_info_nooverlap()
In-Reply-To: <1432802414-12355-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1432802414-12355-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1432802414-12355-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20150528104939.0dd3e461@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, 28 May 2015 10:40:14 +0200, Thomas Petazzoni wrote:

> diff --git a/include/linux/mbus.h b/include/linux/mbus.h
> index 611b69f..c7f318d 100644
> --- a/include/linux/mbus.h
> +++ b/include/linux/mbus.h
> @@ -54,6 +54,7 @@ struct mbus_dram_target_info
>   */
>  #ifdef CONFIG_PLAT_ORION
>  extern const struct mbus_dram_target_info *mv_mbus_dram_info(void);
> +extern const struct mbus_dram_target_info *mv_mbus_dram_info_nooverlap(void);
>  #else
>  static inline const struct mbus_dram_target_info *mv_mbus_dram_info(void)
>  {

I obviously forgot to add mv_mbus_dram_info_nooverlap() in the #else
case here. I'll do it for v2, but I'll wait a bit for other comments
before sending the v2.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
