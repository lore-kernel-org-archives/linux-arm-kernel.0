From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sun, 30 Oct 2016 21:07:04 +0100
Subject: [PATCH 1/2] ABI: rtc-ab8500: fix rtc_calibration documentation
In-Reply-To: <364a36215c44e0c2785911e9d9259cd866283cb9.1477735797.git.mchehab@s-opensource.com>
References: <364a36215c44e0c2785911e9d9259cd866283cb9.1477735797.git.mchehab@s-opensource.com>
Message-ID: <20161030200704.7skfbgt643kzmds4@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/10/2016 at 08:10:02 -0200, Mauro Carvalho Chehab wrote :
> The "What:" field at the ABI should describe the location of
> the ABI, e. g. the position under a mounted sysfs.
> 
> Fix it.
> 
> Cc: Mark Godfrey <mark.godfrey@stericsson.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: rtc-linux at googlegroups.com
> Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> ---
>  .../ABI/testing/sysfs-class-rtc-rtc0-device-rtc_calibration          | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
