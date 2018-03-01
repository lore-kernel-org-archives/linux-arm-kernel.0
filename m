From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 1 Mar 2018 14:46:20 +0100
Subject: [PATCH v2] rtc: brcmstb-waketimer: Set wktmr prescaler
In-Reply-To: <1519675798-26720-1-git-send-email-justin.chen@broadcom.com>
References: <1519675798-26720-1-git-send-email-justin.chen@broadcom.com>
Message-ID: <20180301134620.GX1479@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/02/2018 at 12:09:58 -0800, Justin Chen wrote:
> The HW default is one tick per second, however instead of assuming this,
> lets make sure the waketimer is actually one tick per second before
> arming the alarm.
> 
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Justin Chen <justinpopo6@gmail.com>
> ---
>  drivers/rtc/rtc-brcmstb-waketimer.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
