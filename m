From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 12 Apr 2016 09:29:34 +0200
Subject: [PATCH v9 04/20] PM / devfreq: Add new DEVFREQ_TRANSITION_NOTIFIER
 notifier
In-Reply-To: <1460347078-15175-5-git-send-email-cw00.choi@samsung.com>
References: <1460347078-15175-1-git-send-email-cw00.choi@samsung.com>
 <1460347078-15175-5-git-send-email-cw00.choi@samsung.com>
Message-ID: <570CA3DE.2030702@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/2016 05:57 AM, Chanwoo Choi wrote:
> This patch adds the new DEVFREQ_TRANSITION_NOTIFIER notifier to send
> the notification when the frequency of device is changed.
> This notifier has two state as following:
> - DEVFREQ_PRECHANGE  : Notify it before chaning the frequency of device
> - DEVFREQ_POSTCHANGE : Notify it after changed the frequency of device
> 
> And this patch adds the resourced-managed function to release the resource
> automatically when error happen.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> [m.reichl and linux.amoon: Tested it on exynos4412-odroidu3 board]
> Tested-by: Markus Reichl <m.reichl@fivetechno.de>
> Tested-by: Anand Moon <linux.amoon@gmail.com>
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 163 +++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/devfreq.h   |  59 ++++++++++++++++-
>  2 files changed, 220 insertions(+), 2 deletions(-)


Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
