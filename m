From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 19 Mar 2013 11:49:38 -0700
Subject: [PATCH v6 00/16] clk: exynos4/5: migrate to common clock framework
In-Reply-To: <1361175686-19400-1-git-send-email-thomas.abraham@linaro.org>
References: <1361175686-19400-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <20130319184938.8663.18115@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Thomas Abraham (2013-02-18 00:21:10)
> Changes since v5:
> - Squashed several Exynos4 fixes patch from Tomasz Figa
> - Included support for Exynos5250 and Exynos5440, thus converting all
>   Exynos4 and Exynos5 platforms to common clock framework.
> - Depends on the following patch series.
>   - http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg15849.html
>   - http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg15852.html
> 
> Changes since v4:
> - Rebased to linux-3.8-rc1.
> 
> Changes since v3:
> - Includes changes suggested by Tomasz Figa <tomasz.figa@gmail.com>
> 
> This patch series migrates the Samsung Exynos4/5 SoC clock code to adopt the
> common clock framework. The use of Samsung specific clock structures has
> been removed and all board support code has been updated. imx-style of
> clock registration and lookup has been adopted for device tree based
> exynos4/5 platforms.

Thomas,

Are you planning a V7 series which includes the clock alias bits from
patch #1?

Regards,
Mike
