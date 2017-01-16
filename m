From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Mon, 16 Jan 2017 13:40:57 +0000
Subject: [PATCH] arm64: defconfig: disable CONFIG_DEVMEM
In-Reply-To: <20170115124254.GF25883@bivouac.eciton.net>
References: <20170113113734.16524-1-leif.lindholm@linaro.org>
 <20170113114801.GD3253@arm.com>
 <20170115124254.GF25883@bivouac.eciton.net>
Message-ID: <20170116134057.GH25883@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 15, 2017 at 12:42:54PM +0000, Leif Lindholm wrote:
> On a side note, comparing the resulting configs, there is a
> semi-broken config dependency in lib/Kconfig.debug, meaning
> CONFIG_*STRICT_DEVMEM get set even if CONFIG_DEVMEM is not. 
> But I'll send that out as a separate patch.

Ah - never mind, that one has already been fixed upstream for 4.10rc.

/
    Leif
