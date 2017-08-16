From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 16 Aug 2017 21:22:32 +0200
Subject: [PATCH 6/7] ASoC: samsung: make snd_soc_ops const
In-Reply-To: <1502902770-3758-7-git-send-email-bhumirks@gmail.com>
References: <1502902770-3758-1-git-send-email-bhumirks@gmail.com>
 <1502902770-3758-7-git-send-email-bhumirks@gmail.com>
Message-ID: <20170816192232.5g7armlu5xpxwz62@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 16, 2017 at 10:29:29PM +0530, Bhumika Goyal wrote:
> Make these const as they are only stored in the ops field of a
> snd_soc_dai_link structure, which is const.
> Done using Coccinelle.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
>  sound/soc/samsung/jive_wm8750.c     | 2 +-
>  sound/soc/samsung/s3c24xx_simtec.c  | 2 +-
>  sound/soc/samsung/s3c24xx_uda134x.c | 2 +-
>  sound/soc/samsung/smdk_spdif.c      | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
