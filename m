From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 18 Jan 2017 16:19:35 +0200
Subject: [PATCH 2/3] pinctrl: dt-bindings: samsung: Add Exynos7 specific
 pinctrl macro definitions
In-Reply-To: <1484718141-28785-3-git-send-email-pankaj.dubey@samsung.com>
References: <1484718141-28785-1-git-send-email-pankaj.dubey@samsung.com>
 <CGME20170118054002epcas5p3b08e2f419976e17a3c584d64776810fd@epcas5p3.samsung.com>
 <1484718141-28785-3-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <20170118141935.eu7wmki7jnjdarkw@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 11:12:20AM +0530, Pankaj Dubey wrote:
> Exynos7 SoC pinctrl configurations are similar to existing Exynos4/5 except
> for FSYS1 pinctrl drive strengths. So adding Exynos7 specific FSYS1 blocks
> pinctrl driver strength related macros which will be used in Exynos7
> DTSi files.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  include/dt-bindings/pinctrl/samsung.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

I will need this header, so Sylwester if it is okay with you, could you
provide a tag with it (or ack it)?

Best regards,
Krzysztof
