From: cjb@laptop.org (Chris Ball)
Date: Mon, 17 Sep 2012 01:41:26 -0400
Subject: [PATCH 29/34] mmc: mxcmmc: remove mach/hardware.h inclusion
In-Reply-To: <1347860103-4141-30-git-send-email-shawn.guo@linaro.org> (Shawn
 Guo's message of "Mon, 17 Sep 2012 13:34:58 +0800")
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
 <1347860103-4141-30-git-send-email-shawn.guo@linaro.org>
Message-ID: <m3392h1a0p.fsf@pullcord.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 17 2012, Shawn Guo wrote:
> It changes the driver to use platform_device_id rather than cpu_is_xxx
> to determine the controller type, and updates the platform code
> accordingly.
>
> As the result, mach/hardware.h inclusion gets removed from the driver.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: linux-mmc at vger.kernel.org

Acked-by: Chris Ball <cjb@laptop.org>

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
