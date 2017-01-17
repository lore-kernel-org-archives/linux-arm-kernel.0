From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 17 Jan 2017 19:36:38 +0200
Subject: [PATCH v2 06/13] pinctrl: samsung: Fix
 samsung_pinctrl_create_functions return value
In-Reply-To: <1484657084-26227-7-git-send-email-m.szyprowski@samsung.com>
References: <1484657084-26227-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170117124459eucas1p1ead13705d84054c1d69b5d7a9795f0e9@eucas1p1.samsung.com>
 <1484657084-26227-7-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20170117173638.hcnzpcsxtz4dlpjk@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2017 at 01:44:37PM +0100, Marek Szyprowski wrote:
> Return proper error code in case of memory allocation failure.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/pinctrl/samsung/pinctrl-samsung.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks for fixing.
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
