From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 25 Nov 2015 09:12:59 -0300
Subject: [PATCH] ARM: exynos_defconfig: Enable NFSv4 client
In-Reply-To: <1448424815-30192-1-git-send-email-k.kozlowski@samsung.com>
References: <1448424815-30192-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <5655A5CB.6060106@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 11/25/2015 01:13 AM, Krzysztof Kozlowski wrote:
> NFS client is already enabled (NFS_FS) and by default it enables clients
> for version 2 and 3. Enable explicitly the version 4 client to utilize
> the newer protocol.
> 
> The NFS client is especially useful for testing kernel in automated
> environments (network boot with network file system).
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
--- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
