From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 26 Jun 2017 23:47:41 +0200
Subject: [PATCH v2 2/2] rtc: brcmstb-waketimer: Add Broadcom STB wake-timer
In-Reply-To: <20170626211503.7471-3-f.fainelli@gmail.com>
References: <20170626211503.7471-1-f.fainelli@gmail.com>
 <20170626211503.7471-3-f.fainelli@gmail.com>
Message-ID: <20170626214741.vmz3froqcmrlyxds@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/06/2017 at 14:15:03 -0700, Florian Fainelli wrote:
> From: Brian Norris <computersforpeace@gmail.com>
> 
> This adds support for the Broadcom STB wake-timer which is a timer in
> the chip's 27Mhz clock domain that offers the ability to wake the system
> (wake-up source) from suspend states (S2, S3, S5). It is supported using
> the rtc framework allowing us to configure alarms for system wake-up.
> 
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/rtc/Kconfig                 |  11 ++
>  drivers/rtc/Makefile                |   1 +
>  drivers/rtc/rtc-brcmstb-waketimer.c | 325 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 337 insertions(+)
>  create mode 100644 drivers/rtc/rtc-brcmstb-waketimer.c
> 

Both applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
