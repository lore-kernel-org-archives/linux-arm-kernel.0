From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sun, 3 May 2015 11:58:31 +0200
Subject: [PATCH 1/3] rtc: ab8500: Constify platform_device_id
In-Reply-To: <1430495077-31179-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1430495077-31179-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <20150503095831.GQ12076@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/05/2015 at 00:44:35 +0900, Krzysztof Kozlowski wrote :
> The platform_device_id is not modified by the driver and core uses it as
> const.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
> ---
>  drivers/rtc/rtc-ab8500.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
