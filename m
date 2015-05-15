From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 May 2015 22:03:23 +0200
Subject: [PATCH v4 7/7] ARM: zx: Add basic defconfig support for ZX296702
In-Reply-To: <1430212691-16009-8-git-send-email-jun.nie@linaro.org>
References: <1430212691-16009-1-git-send-email-jun.nie@linaro.org>
 <1430212691-16009-8-git-send-email-jun.nie@linaro.org>
Message-ID: <8162482.vKSVHxgVUp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 28 April 2015 17:18:11 Jun Nie wrote:
> Add basic defconfig support to zx SOC, including uart, mmc
>  and other common config
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> 

Applied to next/defconfig. Please follow up with a patch to enable this
platform in multi_v7_defconfig as well. You should enable all drivers
for devices that are used on this platform, but preferrably use =m
instead of =y in the multi_v7_defconfig (in zx_defconfig, it's up
to your personal preference).

Thanks,

	Arnd
