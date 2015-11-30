From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 30 Nov 2015 20:04:10 +0100
Subject: [PATCH] Rtc: rtc-gemini.c: Remove unnecessary
 platform_set_drvdata()
In-Reply-To: <1447446089-2346-1-git-send-email-nizamhaider786@gmail.com>
References: <1447446089-2346-1-git-send-email-nizamhaider786@gmail.com>
Message-ID: <20151130190410.GJ22136@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/11/2015 at 01:51:29 +0530, Nizam Haider wrote :
> The driver core clears the driver data to NULL after device_release
> or on probe failure
> 
> Signed-off-by: Nizam Haider <nijamh@cdac.in>
> ---
>  drivers/rtc/rtc-gemini.c | 1 -
>  1 file changed, 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
