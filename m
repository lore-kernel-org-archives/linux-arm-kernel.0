From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 6 Mar 2018 17:49:39 +0100
Subject: [PATCH v5 4/6] arm64: dts: exynos: add OF graph between MHL and
 USB connector
In-Reply-To: <20180227071134.28063-5-a.hajda@samsung.com>
References: <20180227071134.28063-1-a.hajda@samsung.com>
 <CGME20180227071140eucas1p15a8b8443c6d52c5fab79cc82c37dce09@eucas1p1.samsung.com>
 <20180227071134.28063-5-a.hajda@samsung.com>
Message-ID: <20180306164939.jqpfawa6u2c2xb5e@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 27, 2018 at 08:11:32AM +0100, Andrzej Hajda wrote:
> OF graph describes MHL data lanes between MHL and respective USB
> connector.
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
> v5: removed extra parenthesis (kbuild test robot)
> v4: added missing reg property in connector's port node (Krzysztof)
> ---
>  .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 31 +++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
> 

Thanks, applied.

Best regards,
Krzysztof
