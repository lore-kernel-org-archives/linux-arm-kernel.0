From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 3 Jan 2017 18:49:55 +0200
Subject: [PATCH 4/4] arm64: dts: exynos: Add tm2 touchkey node
In-Reply-To: <1483430237-26823-5-git-send-email-jcsing.lee@samsung.com>
References: <1483430237-26823-1-git-send-email-jcsing.lee@samsung.com>
 <CGME20170103075734epcas5p439b05860a3238ce638f683d9687786a3@epcas5p4.samsung.com>
 <1483430237-26823-5-git-send-email-jcsing.lee@samsung.com>
Message-ID: <20170103164955.2oqyd2du2dom7wym@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 03, 2017 at 04:57:17PM +0900, Jaechul Lee wrote:
> Add DT node support for TM2 touchkey device.
> 
> Signed-off-by: Jaechul Lee <jcsing.lee@samsung.com>
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>

The order of sign-offs should follow the order of "who touched it". I
assume that the real order was like this:
1. Initially create by Beomho,
2. Adjustments by Andi,
3. Final adjustments and sending by you.

If that is correct then the order should be 1->2->3.

Beside of that, patch looks good.

Best regards,
Krzysztof
