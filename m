From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 12 Apr 2016 16:20:12 +0200
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: Enable CPUFreq governors as
 modules
In-Reply-To: <1460142130-31822-2-git-send-email-javier@osg.samsung.com>
References: <1460142130-31822-1-git-send-email-javier@osg.samsung.com>
 <1460142130-31822-2-git-send-email-javier@osg.samsung.com>
Message-ID: <CAJKOXPePp9S9y=vrOf+H0Vu_vD_AZ0VN+MUTBQWyZRF3PowRNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 8, 2016 at 9:02 PM, Javier Martinez Canillas
<javier@osg.samsung.com> wrote:
> Currently only the ondemand and performance CPUFreq policy governors are
> enabled in multi_v7 defconfig. But the other governors are also useful
> for some cases, enable them to allow users change the default if needed.
>
> The options are enabled as module to keep the kernel image size minimal.
>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>
> ---
>
>  arch/arm/configs/multi_v7_defconfig | 4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks.

Krzysztof
