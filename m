From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 13 Nov 2018 20:32:54 +0100
Subject: [PATCHv5 2/6] ARM: dts: exynos: fix regulator min values of
 LDO13 for Odroid XU3/XU4
In-Reply-To: <20180927140738.1006-3-linux.amoon@gmail.com>
References: <20180927140738.1006-1-linux.amoon@gmail.com>
 <20180927140738.1006-3-linux.amoon@gmail.com>
Message-ID: <20181113193254.GC2418@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2018 at 02:07:34PM +0000, Anand Moon wrote:
> Looking at the schematic sd_2 min/max range from 1.8V/2.8V so fix the
> regulator min value to 1.8V. Without these changes sdcard will failed
> to detect on booting when UHS-I tuning is enabled.
> 

Thanks, applied.

Best regards,
Krzysztof
