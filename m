From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 21 Aug 2015 09:48:22 +0900
Subject: [PATCH] ASoC: Samsung: Remove redundant arndale_audio_remove
In-Reply-To: <20150820164115.GA19191@localhost>
References: <20150820164115.GA19191@localhost>
Message-ID: <55D67556.4040500@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21.08.2015 01:41, Vaishali Thakkar wrote:
> There is no use of snd_soc_unregister_card in remove function
> as devm_snd_soc_register_card in probe function automatically
> handles it. So, remove use of snd_soc_unregister_card and with
> this change remove arndale_audio_remove as it is now redundant.
> 
> Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>z
> ---
>  sound/soc/samsung/arndale_rt5631.c | 10 ----------
>  1 file changed, 10 deletions(-)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
