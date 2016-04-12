From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 12 Apr 2016 16:15:13 +0200
Subject: [PATCH 1/2] ARM: exynos_defconfig: Enable CPUFreq governors as
 modules
In-Reply-To: <1460142130-31822-1-git-send-email-javier@osg.samsung.com>
References: <1460142130-31822-1-git-send-email-javier@osg.samsung.com>
Message-ID: <CAJKOXPd+YstrV92ON+0CUzMXGccsYo9G0QDrx=WTaujoPDwDZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 8, 2016 at 9:02 PM, Javier Martinez Canillas
<javier@osg.samsung.com> wrote:
> Currently only the ondemand and performance CPUFreq policy governors are
> enabled in the Exynos defconfig. But the other governors are also useful
> for some cases, enable them to allow users change the default if needed.
>
> The options are enabled as module to keep the kernel image size minimal.
>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
>
>  arch/arm/configs/exynos_defconfig | 4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks.

Krzysztof
