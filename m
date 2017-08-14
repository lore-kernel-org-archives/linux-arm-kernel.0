From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 14 Aug 2017 21:12:33 +0200
Subject: [PATCH 08/11] ASoC: samsung: make snd_soc_platform_driver const
In-Reply-To: <1502710730-18912-9-git-send-email-bhumirks@gmail.com>
References: <1502710730-18912-1-git-send-email-bhumirks@gmail.com>
 <1502710730-18912-9-git-send-email-bhumirks@gmail.com>
Message-ID: <20170814191233.oxommdb5r5nf2c2e@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 14, 2017 at 05:08:47PM +0530, Bhumika Goyal wrote:
> Make this const as it is only passed as the 2nd argument to the function
> devm_snd_soc_register_platform, which is of type const.
> Done using Coccinelle.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
>  sound/soc/samsung/idma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
