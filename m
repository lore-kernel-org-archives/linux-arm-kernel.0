From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 15 Oct 2012 17:07:40 +0100
Subject: [PATCH 1/2] mmc: core: Support all MMC capabilities when booting
 from Device Tree
In-Reply-To: <201210151420.29930.arnd@arndb.de>
References: <1350306959-5843-1-git-send-email-lee.jones@linaro.org>
 <201210151420.29930.arnd@arndb.de>
Message-ID: <20121015160740.GC7662@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Monday 15 October 2012, Lee Jones wrote:
> > Capabilities are an important part of the MMC subsystem. Much
> > supported functionality would be lost if we didn't provide the
> > same level of support when booting Device Tree as we currently
> > do when the subsystem is passed capabilities via platform data.
> > This patch supplies this support with one simple call to a
> > DT parsing function.
> 
> We already document all the commonly used properties
> in Documentation/devicetree/bindings/mmc/mmc.txt

<snip>

> and so on. What are you actually missing in the properties that
> are already there?

MMC_CAP_ERASE
MMC_CAP_UHS_SDR12
MMC_CAP_UHS_SDR25
MMC_CAP_UHS_DDR50
MMC_CAP_1_8V_DDR

MMC_CAP2_DETECT_ON_ERR
MMC_CAP2_NO_SLEEP_CMD

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
