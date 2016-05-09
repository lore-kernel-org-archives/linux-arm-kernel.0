From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 9 May 2016 17:44:54 -0400
Subject: [PATCH v2 19/22] ARM: dts: exynos: MCT is not an interrupt
 controller and extend length of iomap
In-Reply-To: <1462734367-5619-20-git-send-email-krzk@kernel.org>
References: <1462734367-5619-1-git-send-email-krzk@kernel.org>
 <1462734367-5619-20-git-send-email-krzk@kernel.org>
Message-ID: <cd2cfef1-f9a8-0daa-e4bc-c00b0943c52e@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 05/08/2016 03:06 PM, Krzysztof Kozlowski wrote:
> Multi-Core Timer generates interrupts but it is not really an interrupt
> controller so remove the "interrupt-controller" and "interrupt-cells"
> properties. Additionally extend the length of mapped memory to cover all
> registers (last SFR is at 0x0A40).
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
