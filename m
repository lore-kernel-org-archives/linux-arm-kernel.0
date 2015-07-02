From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 2 Jul 2015 21:09:39 +0200
Subject: [PATCH] rtc-mt6397: enable wakeup before registering rtc device
In-Reply-To: <1435826216-11982-1-git-send-email-wnhuang@google.com>
References: <1435826216-11982-1-git-send-email-wnhuang@google.com>
Message-ID: <20150702190939.GE3467@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07/2015 at 16:36:56 +0800, Wei-Ning Huang wrote :
> rtc_sysfs_add_device checks if device can wakeup before creating the
> wakealarm file in sysfs. Thus the driver must set wakeup capability
> before registering the rtc device.
> 
> Signed-off-by: Wei-Ning Huang <wnhuang@google.com>
> ---
>  drivers/rtc/rtc-mt6397.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
Applied on rtc-fixes, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
