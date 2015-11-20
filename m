From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 20 Nov 2015 09:55:44 +0800
Subject: [PATCH v2 1/3] ARM: sunxi: Re-enable SID driver in sunxi_defconfig
In-Reply-To: <1447983979-12751-1-git-send-email-public_timo.s@silentcreek.de>
References: <1447724578-4786-1-git-send-email-public_timo.s@silentcreek.de>
 <1447983979-12751-1-git-send-email-public_timo.s@silentcreek.de>
Message-ID: <CAGb2v66EJcOLG8Pq1YjhV4VVBMx7gJsb3fgcsG8kVHfDrOJPOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2015 at 9:46 AM, Timo Sigurdsson
<public_timo.s@silentcreek.de> wrote:
> Commit 3d0b16a66c8a ("nvmem: sunxi: Move the SID driver to the nvmem
> framework") moved the the sunxi SID driver to a new framework, but left
> sunxi_defconfig with the deprecated config symbol EEPROM_SUNXI_SID
> instead of the new symbol NVMEM_SUNXI_SID. Hence, re-enable the driver
> in sunxi_defconfig.
>
> Signed-off-by: Timo Sigurdsson <public_timo.s@silentcreek.de>

Acked-by: Chen-Yu Tsai <wens@csie.org>
