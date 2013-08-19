From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 19 Aug 2013 20:02:55 +0100
Subject: [PATCH v4 1/3] ARM: bcm281xx: Add GPIO driver
In-Reply-To: <1376938761-13657-2-git-send-email-markus.mayer@linaro.org>
References: <1376938761-13657-1-git-send-email-markus.mayer@linaro.org>
 <1376938761-13657-2-git-send-email-markus.mayer@linaro.org>
Message-ID: <17431632.gcbUH2MqH0@lenovo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Markus,

Le lundi 19 ao?t 2013 11:59:19 Markus Mayer a ?crit :
> From: Markus Mayer <mmayer@broadcom.com>
> 
> This patch adds the GPIO driver for the bcm281xx family of chips.
> 
> Signed-off-by: Markus Mayer <markus.mayer@linaro.org>
> Reviewed-by: Christian Daudt <csd@broadcom.com>
> Reviewed-by: Tim Kryger <tim.kryger@linaro.org>
> Reviewed-by: Matt Porter <matt.porter@linaro.org>
> ---
>  .../devicetree/bindings/gpio/gpio-bcm-kona.txt     |   43 ++

Since the vendor prefix has been changed from brcm to bcm, should that also be 
reflected in the Device Tree binding documentation file?
-- 
Florian
