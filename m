From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 13 Sep 2016 15:21:46 +0800
Subject: [PATCH v5 0/3] Add ZTE ZX296718 support
In-Reply-To: <1473730926-1034-1-git-send-email-jun.nie@linaro.org>
References: <1473730926-1034-1-git-send-email-jun.nie@linaro.org>
Message-ID: <20160913072146.GA7398@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 13, 2016 at 09:42:03AM +0800, Jun Nie wrote:
> Changes in version5:
>   - Add GPL license to new files.
>   - Unify clocks dts nodes names.
>   - Move interrupt parents info to root nodes in dts, move
>     pmu and timer node out of soc node.
> 
> Changes in version4:
>   - Change dts file name to align with compatible name.
>   - Reorder dts nodes with reg address sequence.
>   - Move nodes out of soc, which do not have soc simple
>     bus address or share soc interrupt.
>   - Change some nodes name to align with convention.
> 
> Changes in version3:
>   - Remove unnecessary flag of gic in dts.
> 
> Changes in version2:
>   - Use more precise cpu and pmu compatible name in dts.
>   - fix minor coding style issue.
> 
> 
> Jun Nie (3):
>   arm64: add ZTE ZX SoC family
>   arm64: dts: Add ZTE ZX296718 SoC dts and Makefile
>   arm64: defconfig: enable ZTE ZX related config

For the series,

Reviewed-by: Shawn Guo <shawnguo@kernel.org>

Arnd, Olof,

If you like, I can help collect ZTE DTS patches to reduce your
maintenance burden, considering we have an established pull-request
work flow and I get ZTE platform on hands to test patches.

Shawn
