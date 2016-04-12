From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 12 Apr 2016 09:24:13 +0200
Subject: [PATCH v9 03/20] PM / devfreq: Add
 devfreq_get_devfreq_by_phandle()
In-Reply-To: <1460347078-15175-4-git-send-email-cw00.choi@samsung.com>
References: <1460347078-15175-1-git-send-email-cw00.choi@samsung.com>
 <1460347078-15175-4-git-send-email-cw00.choi@samsung.com>
Message-ID: <570CA29D.9030308@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/2016 05:57 AM, Chanwoo Choi wrote:
> This patch adds the new devfreq_get_devfreq_by_phandle() OF helper function
> which can find the instance of devfreq device by using phandle ("devfreq").
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> [m.reichl and linux.amoon: Tested it on exynos4412-odroidu3 board]
> Tested-by: Markus Reichl <m.reichl@fivetechno.de>
> Tested-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/devfreq/devfreq.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/devfreq.h   |  9 +++++++++
>  2 files changed, 53 insertions(+)
> 

Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
