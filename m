From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 16 Jun 2016 09:57:00 -0400
Subject: [PATCH V2 2/4] clk: Combine DT binding doc for max77686 and
 max77802
In-Reply-To: <1466083407-28793-3-git-send-email-ldewangan@nvidia.com>
References: <1466083407-28793-1-git-send-email-ldewangan@nvidia.com>
 <1466083407-28793-3-git-send-email-ldewangan@nvidia.com>
Message-ID: <915cfaa2-074c-c0b4-5b5a-81857e329693@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Laxman,

On 06/16/2016 09:23 AM, Laxman Dewangan wrote:
> The clock IP used on the Maxim PMICs max77686 and max77802 are
> same. The configuration of clock register is also same except
> the number of clocks.
> 
> Define the common DT binding file for the clocks of Maxim PMICs
> MAX77686 and MAX77802. For this, remove the separate DT binding
> document file for maxim,max77802 and move all information to
> maxim,max77686 DT binding document.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> CC: Javier Martinez Canillas <javier@dowhile0.org>
> 

Looks good to me.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
