From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 30 Apr 2014 14:11:43 +0530
Subject: [PATCH v3 05/12] ARM: EXYNOS: Remove file path from comment
 section
In-Reply-To: <1398835057-3860-6-git-send-email-pankaj.dubey@samsung.com>
References: <1398835057-3860-1-git-send-email-pankaj.dubey@samsung.com>
 <1398835057-3860-6-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <CAK9yfHy8kbNk6mVZy_ARiWZ8kLbn7r7R8vj+3ETCcGsASQZsCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pankaj,

On 30 April 2014 10:47, Pankaj Dubey <pankaj.dubey@samsung.com> wrote:
> Many files under "arm/mach-exynos" are having file path in file
> comment section which is invalid now.
> So for better code maintainability let's remove them.
>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> ---

The change is sensible. However Kukjin had refused to accept such patches
when I had submitted patches doing such cleanup for all Samsung platform files.

Anyway, FWIW
Reviewed-by: Sachin Kamat <sachin.kamat@linaro.org>

-- 
With warm regards,
Sachin
