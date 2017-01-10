From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 10 Jan 2017 20:42:34 +0200
Subject: [PATCH v2 0/3] arm64: dts: exynos: Fix DTC warnings for Exynos
 boards
In-Reply-To: <1484069912-6534-1-git-send-email-javier@osg.samsung.com>
References: <1484069912-6534-1-git-send-email-javier@osg.samsung.com>
Message-ID: <20170110184234.rzxedwnvsun7cfk2@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 10, 2017 at 02:38:29PM -0300, Javier Martinez Canillas wrote:
> Hello Krzysztof,
> 
> This trivial series contains fixes for DTC warnings caused by mismatches
> between unit names and reg properties in device tree nodes.
> 
> The patches shouldn't cause a functional change but have been just build
> tested. I compared the generated DTB though to make sure that only these
> nodes changed.
> 
> Best regards,
> Javier
> 
> Changes since v1:
>   - Fix subject line since I forgot the "exynos" prefix.

Thanks :)

Best regards,
Krzysztof
