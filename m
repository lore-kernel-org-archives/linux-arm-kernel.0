From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 18 Nov 2014 00:25:10 +0100
Subject: exynos boot falures in linux-next
In-Reply-To: <7hlhn9zcse.fsf@deeprootsystems.com>
References: <E1XqKYI-0000pQ-4b@ip-10-35-177-41.ec2.internal>	<7hoas54y7k.fsf@deeprootsystems.com>
 <7hlhn9zcse.fsf@deeprootsystems.com>
Message-ID: <546A83D6.9060504@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Kevin,

On 11/17/2014 11:24 PM, Kevin Hilman wrote:
> 
> As might have been expected, reverting the change that enables the
> DRM/display options in exynos_defconfig fixes the problem.
> 
> Kevin
>

I'm sorry for causing a boot failure but when I first posted that patch,
the Exynos DRM driver was working correctly (at least on the Exynos boards
I've access to) so it seems the regression was introduced while the patch
was posted but not yet picked.

I'm not sure what is the correct step in this case but I'm OK with
reverting the patch until the Exynos DRM driver bug is fixed.

Best regards,
Javier
