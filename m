From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sun, 3 May 2015 11:59:13 +0200
Subject: [PATCH 3/3] rtc: mxc: Constify platform_device_id
In-Reply-To: <1430495077-31179-3-git-send-email-k.kozlowski.k@gmail.com>
References: <1430495077-31179-1-git-send-email-k.kozlowski.k@gmail.com>
 <1430495077-31179-3-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <20150503095913.GS12076@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/05/2015 at 00:44:37 +0900, Krzysztof Kozlowski wrote :
> The platform_device_id is not modified by the driver and core uses it as
> const.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
> ---
>  drivers/rtc/rtc-mxc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
