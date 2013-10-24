From: balbi@ti.com (Felipe Balbi)
Date: Thu, 24 Oct 2013 10:31:29 -0500
Subject: [PATCH] drivers: video: exynos: Fix compiler Warning
In-Reply-To: <1382628454-11951-1-git-send-email-kishon@ti.com>
References: <CAOesGMhwotSY-1WQmt+wtsrsH2m30VE=j-MwyhpYU3mt_PSPPw@mail.gmail.com>
 <1382628454-11951-1-git-send-email-kishon@ti.com>
Message-ID: <20131024153129.GH2834@gimli>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 24, 2013 at 08:57:34PM +0530, Kishon Vijay Abraham I wrote:
> Fixed the following compilation warning:
> ../../drivers/video/exynos/exynos_mipi_dsi.c: In function
> 'exynos_mipi_dsi_blank_mode':
> ../../drivers/video/exynos/exynos_mipi_dsi.c:144:26: warning: unused
> variable 'pdev' [-Wunused-variable]
>   struct platform_device *pdev = to_platform_device(dsim->dev);
> 
> Reported-by: Olof Johansson <olof@lixom.net>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

pretty obvious patch:

Reviewed-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131024/7d86c480/attachment.sig>
