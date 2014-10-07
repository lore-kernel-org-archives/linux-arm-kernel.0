From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Tue, 7 Oct 2014 14:32:53 +0200
Subject: [PATCH v9 1/2] ARM: exynos5: Add PMU support for 5420
In-Reply-To: <1412673723-15551-2-git-send-email-vikas.sajjan@samsung.com>
References: <1412673723-15551-1-git-send-email-vikas.sajjan@samsung.com>
 <1412673723-15551-2-git-send-email-vikas.sajjan@samsung.com>
Message-ID: <CABxcv==38sEFnpXaWoL6pvzyF7XH+DA55cP2MDPgfY=zBwxVUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hellos Vikas,

On Tue, Oct 7, 2014 at 11:22 AM, Vikas Sajjan <vikas.sajjan@samsung.com> wrote:
> From: Abhilash Kesavan <a.kesavan@samsung.com>
>
> Adds intial PMU settings for exynos5420. This is required for
> future S2R and Switching support.
>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
> ---
>  arch/arm/mach-exynos/pmu.c      |  287 +++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-exynos/regs-pmu.h |  227 +++++++++++++++++++++++++++++++
>  2 files changed, 514 insertions(+)

S2R is working on my Exynos5420 Peach Pit Chromebook with your series:

Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
