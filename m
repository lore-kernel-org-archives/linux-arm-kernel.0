From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 20 Apr 2016 00:37:55 +0200
Subject: [PATCH 1/3] RTC: Enable RTC switching to battery power when
 VCC_PSAUX is N/A
In-Reply-To: <1460463346-24923-1-git-send-email-anuragku@xilinx.com>
References: <1460463346-24923-1-git-send-email-anuragku@xilinx.com>
Message-ID: <20160419223755.GG29844@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/04/2016 at 17:45:44 +0530, Anurag Kumar Vulisha wrote :
> In order to conserve battery energy, during the PS operation,
> it is expected that the supply for the battery-powered domain
> to be switched from the battery (VCC_PSBATT) to (VCC_PSAUX) and
> automatically be switched back to battery when VCC_PSAUX voltage
> drops below a limit, doing so prevents the logic within
> the battery-powered domain from functioning incorrectly.
> 
> This patch enables that feature.
> 
> Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>
> ---
>  drivers/rtc/rtc-zynqmp.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
