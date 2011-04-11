From: grinberg@compulab.co.il (Igor Grinberg)
Date: Mon, 11 Apr 2011 09:11:01 +0300
Subject: [PATCH] fix build warnings on defconfigs
In-Reply-To: <1302375858-11253-1-git-send-email-wanlong.gao@gmail.com>
References: <1302375858-11253-1-git-send-email-wanlong.gao@gmail.com>
Message-ID: <4DA29B75.4090401@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/09/11 22:04, wanlong.gao at gmail.com wrote:

> From: Wanlong Gao <wanlong.gao@gmail.com>
>
> Change the BT_L2CAP and BT_SCO defconfigs from 'm' to 'y',
> since BT_L2CAP and BT_SCO had changed to bool configs.
>
> Signed-off-by: Wanlong Gao <wanlong.gao@gmail.com>
> ---

For:

>  arch/arm/configs/cm_x2xx_defconfig         |    4 ++--
>  arch/arm/configs/cm_x300_defconfig         |    4 ++--
>  arch/arm/configs/em_x270_defconfig         |    4 ++--

Acked-by: Igor Grinberg <grinberg@compulab.co.il>

-- 
Regards,
Igor.
