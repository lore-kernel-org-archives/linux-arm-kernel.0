From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 28 May 2013 09:07:58 -0600
Subject: [PATCH v2 0/5] ARM: dts: OMAP2+: use preprocessor for device trees
In-Reply-To: <1369323421-4180-1-git-send-email-florian.vaussard@epfl.ch>
References: <1369323421-4180-1-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <51A4C84E.4070005@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/23/2013 09:36 AM, Florian Vaussard wrote:
> Hello,
> 
> Following a similar proposal by Stephen Warren for tegra [1], this series
> makes use of the C preprocessor when compiling OMAP DT files, and
> accomplishes some improvements to improve overall readability.
> 
> Patch 1 is a preparation for the rest of the series.
> Patch 2 uses existing constants for GPIOs. Patch 3 does the same for
> IRQs. Patch 4 creates a new header for OMAP's padmux, and patch 5 uses
> it to simplify pinctrl DT.
> 
> For all targets, the .dtb files were diff-tested before and after
> applying the series to guarantee identity.

The series briefly,

Reviewed-by: Stephen Warren <swarren@nvidia.com>
