From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 22 Jul 2018 17:08:12 +0200
Subject: [PATCHv2] ARM: dts: exynos5: add missing interrupts for pwm node
In-Reply-To: <1531918767-7177-1-git-send-email-linux.amoon@gmail.com>
References: <1531918767-7177-1-git-send-email-linux.amoon@gmail.com>
Message-ID: <20180722150812.dmk2qmhp3jwejt3b@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 18, 2018 at 12:59:27PM +0000, Anand Moon wrote:
> Add missing GIC interrupts property for pwm nodes.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> Fixed the patch indentation issue with all tabs.
> sorry checkpatch could not figure out the error.
> ---
>  arch/arm/boot/dts/exynos5.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)

Thanks, applied with fixed subsystem prefix in subject and indentation.

Best regards,
Krzysztof
