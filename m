From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 30 Aug 2013 10:23:03 +0200
Subject: [PATCH v4 0/5] ARM: tegra: support for Trusted Foundations
In-Reply-To: <1377770268-14014-1-git-send-email-acourbot@nvidia.com>
References: <1377770268-14014-1-git-send-email-acourbot@nvidia.com>
Message-ID: <13779002.NFLbqBjPSE@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

On Thursday 29 of August 2013 18:57:43 Alexandre Courbot wrote:
> New version revised according to comments received for v3. Hopefully
> it will be good enough to be merged.
> 
> Changes since v3:
> - Added of_register_trusted_foundations() function to avoid duplicate
>   device tree parsing code in arch files
> - Added ability to initialize Trusted Foundations through platform data
> - Changed TF version number to integers
> - Refactored Kconfig menu for more clarity

Except some minor comments to patch 1/5, the series looks good to me.

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
