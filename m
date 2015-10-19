From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 19 Oct 2015 14:13:56 +0530
Subject: [1/7] arm: dts: Add syscon-{reboot,
 poweroff} nodes for exynos3250 SoCs
In-Reply-To: <1445234635-3950-2-git-send-email-alim.akhtar@samsung.com>
References: <1445234635-3950-2-git-send-email-alim.akhtar@samsung.com>
Message-ID: <5624AD4C.2000601@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 October 2015 11:33 AM, Alim Akhtar wrote:
> This patch adds syscon-{reboot, poweroff} nodes to allow the
> generic syscon-{reboot, poweroff} driver to reset/poweroff exynos3250 SoC.
>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>
> ---
> arch/arm/boot/dts/exynos3250.dtsi |   14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>

Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>

Thanks,
Pankaj Dubey
