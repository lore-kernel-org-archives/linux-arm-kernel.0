From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 6 Nov 2015 16:37:43 +0000
Subject: [PATCH v2] arm64: defconfig: Enable samsung MFD and related
 configs
In-Reply-To: <CAJKOXPeWerSTi2QedEwyHRVN4xA0vWM2CSOvb5v9SWUmOSPe7Q@mail.gmail.com>
References: <1446787654-18306-1-git-send-email-alim.akhtar@samsung.com>
 <CAJKOXPeWerSTi2QedEwyHRVN4xA0vWM2CSOvb5v9SWUmOSPe7Q@mail.gmail.com>
Message-ID: <20151106163743.GA7637@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 06, 2015 at 02:47:12PM +0900, Krzysztof Kozlowski wrote:
> 2015-11-06 14:27 GMT+09:00 Alim Akhtar <alim.akhtar@samsung.com>:
> > Exynos7 based espresso board uses S2MPS15, a multifunction device.
> > This patch enables S2MPS1X regulator, pmic-clk and rtc drivers utilized by
> > the same.
> >
> > Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> > ---
> > Changes since v1:
> > * updated the comment message to describe which platfrom uses it.
> > * enable COMMON_CLK_S2MPS11 which is needed to enable pmic-clk block.
> >
> >  arch/arm64/configs/defconfig |    4 ++++
> >  1 file changed, 4 insertions(+)
> 
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> Catalin,
> 
> Are you usually taking such arm64 defconfig changes or should they go
> through arm-soc?

Usually arm-soc but I don't mind either way.

-- 
Catalin
