From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 7 Mar 2017 22:17:46 +0200
Subject: [PATCH v10 3/3] arm64: dts: exynos: Add support for S6E3HA2
 panel device on TM2 board
In-Reply-To: <5be15c1c-ba4c-94d9-30be-8d161e9be7b3@samsung.com>
References: <1487574582-15746-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170220071001epcas1p3c2b32665942ba55c3ed4e06d2c66d661@epcas1p3.samsung.com>
 <5be15c1c-ba4c-94d9-30be-8d161e9be7b3@samsung.com>
Message-ID: <20170307201746.brpn4h2atvueg3l5@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 22, 2017 at 10:09:54AM +0900, Hoegeun Kwon wrote:
> From: Hyungwon Hwang <human.hwang@samsung.com>
> 
> This patch add the panel device tree node for S6E3HA2 display
> controller to TM2 dts.
> 
> Signed-off-by: Hyungwon Hwang <human.hwang@samsung.com>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433-tm2.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

I tried to apply but:
fatal: corrupt patch at line 37
Patch failed at 0001 arm64: dts: exynos: Add support for S6E3HA2 panel
device on TM2 board

Please fix, rebase, add blank link as suggested by Javier and send a
v11.

Best regards,
Krzysztof
