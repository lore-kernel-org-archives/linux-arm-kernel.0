From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 25 Jul 2013 15:14:23 +0530
Subject: [RFC] ARM: davinci: da850: add a few pinmux definitions
In-Reply-To: <1374610382-11204-1-git-send-email-vivien.didelot@savoirfairelinux.com>
References: <1374610382-11204-1-git-send-email-vivien.didelot@savoirfairelinux.com>
Message-ID: <51F0F377.1060204@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vivien,

On Wednesday 24 July 2013 01:43 AM, Vivien Didelot wrote:
> This patch adds some pinmux definitions that we needed, such as SPI0,
> SPI1 and some GPIO.
> 
> Note: I sent the patch as an RFC because I would like a confirmation for the
> appropriate name for SPI*_SCS* and EMA_A_RW pinmuxes.
> 
> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>

Why do you need to add these definitions? If it is for a new platform
you are working on, then it should be supported using DT, in which case
we use the pinctrl-single driver and define the muxing needed in
.dts/.dtsi files.

Thanks,
Sekhar
