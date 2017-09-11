From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 11 Sep 2017 15:34:17 +0530
Subject: [RFC 1/2] configs: davinci_all_defconfig: Enable Backlight PWM
 module
In-Reply-To: <1504933135-29747-1-git-send-email-aford173@gmail.com>
References: <1504933135-29747-1-git-send-email-aford173@gmail.com>
Message-ID: <3ab8a360-2a64-d0a8-049e-0cc65b15244d@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 09 September 2017 10:28 AM, Adam Ford wrote:
> The da850evm had an LCD that used ecap2 as the PWM brightness
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Looks good, please rebase to latest master of my tree as it does not
apply cleanly. Also, please use patch subject line conventions normally
used with the file.

Thanks,
Sekhar
