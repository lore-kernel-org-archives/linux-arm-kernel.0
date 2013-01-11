From: olof@lixom.net (Olof Johansson)
Date: Thu, 10 Jan 2013 17:34:24 -0800
Subject: [PATCH] ARM: dts: sorting the device nodes in alphabetical order
 for EXYNOS DT
In-Reply-To: <1357861132-16275-1-git-send-email-kgene.kim@samsung.com>
References: <1357861132-16275-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <CAOesGMjXSnE_k763T0RiJiZO2dDj1HX_HROU+dTtnVTCMdLnmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 3:38 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> To reduce merge conflicts it would be easier maintain the device nodes
> under the root node sorted in alphabetical order.
>
> Cc: Tomasz Figa <t.figa@samsung.com>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Cc: Olof Johansson <olof@lixom.net>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>

While this would be good to do; it's 600+ lines of pure churn and I
would like to keep the diffstat down in 3.9 given the comments we got
for 3.8.

So, let's hold this off for another release, please.


-Olof
