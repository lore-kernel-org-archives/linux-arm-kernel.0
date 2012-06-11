From: aletes.xgr@gmail.com (Alexandre Pereira da Silva)
Date: Mon, 11 Jun 2012 19:24:54 -0300
Subject: [PATCH 14/14] ARM: LPC32xx: Remove mach specific ARCH_NR_GPIOS,
 use default
In-Reply-To: <1339412537-24485-15-git-send-email-stigge@antcom.de>
References: <1339412537-24485-1-git-send-email-stigge@antcom.de>
 <1339412537-24485-15-git-send-email-stigge@antcom.de>
Message-ID: <CAAAP30FkJPvBFquQmoBFjohzeo-NoOCup8+TGZf+w8FNs1jaJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2012 at 8:02 AM, Roland Stigge <stigge@antcom.de> wrote:
> ARCH_NR_GPIOS was defined statically to include exactly all SoC specific GPIOs.
> Now if additional GPIOs need to be added dynamically, e.g. via DT, none are
> available. Removing the mach specific setting, leaving ARCH_NR_GPIOS to the
> default of 256 (currently in include/asm-generic/gpio.h).
>
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Acked-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
