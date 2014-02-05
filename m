From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 05 Feb 2014 09:43:12 +0900
Subject: [PATCH 06/18] extcon: max14577: Change extcon name instead of
 static name according to device type
In-Reply-To: <1390911522-28209-7-git-send-email-k.kozlowski@samsung.com>
References: <1390911522-28209-1-git-send-email-k.kozlowski@samsung.com>
 <1390911522-28209-7-git-send-email-k.kozlowski@samsung.com>
Message-ID: <52F18920.1070400@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/28/2014 09:18 PM, Krzysztof Kozlowski wrote:
> From: Chanwoo Choi <cw00.choi@samsung.com>
> 
> This patch use device name to make sysfs path according to device type:
> 
> max14577-muic
> - /sys/class/extcon/max14577-muic/
> max77836-muic
> - /sys/class/extcon/max77836-muic/
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> ---

Applied.

Thanks,
Chanwoo Choi
