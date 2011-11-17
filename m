From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Thu, 17 Nov 2011 14:38:11 +0400
Subject: [PATCH v3 5/5] ARM: davinci: delete individual platform header
 files and use a common header
In-Reply-To: <1321525138-3928-6-git-send-email-manjunath.hadli@ti.com>
References: <1321525138-3928-1-git-send-email-manjunath.hadli@ti.com>
 <1321525138-3928-6-git-send-email-manjunath.hadli@ti.com>
Message-ID: <4EC4E413.3020708@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 17-11-2011 14:18, Manjunath Hadli wrote:

> include davinci_common.h file in files using the platform

   Just davinci.h now.

> header file for dm355, dm365, dm644x and dm646x and delete the
> individual platform header files.

> Signed-off-by: Manjunath Hadli<manjunath.hadli@ti.com>

> diff --git a/drivers/media/video/davinci/vpif.h b/drivers/media/video/davinci/vpif.h
> index 25036cb..1e0fef9 100644
> --- a/drivers/media/video/davinci/vpif.h
> +++ b/drivers/media/video/davinci/vpif.h
> @@ -18,8 +18,7 @@
>
>   #include<linux/io.h>
>   #include<linux/videodev2.h>
> -#include<mach/hardware.h>

    You need to either describe this change, or do it in a sperate patch.

WBR, Sergei
