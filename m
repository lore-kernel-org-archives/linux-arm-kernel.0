From: emil.l.velikov@gmail.com (Emil Velikov)
Date: Wed, 2 Sep 2015 15:50:37 +0100
Subject: [PATCH v4 03/16] drm: bridge: analogix/dp: split exynos dp driver
 to bridge dir
In-Reply-To: <1441086598-24995-1-git-send-email-ykk@rock-chips.com>
References: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>
 <1441086598-24995-1-git-send-email-ykk@rock-chips.com>
Message-ID: <CACvgo53pZUtSLRGVMYPs1s4QPBrAr3j=xoZ1t23tPv202bzfyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Dropping the CC list]

Hi Yakir Yang,

On 1 September 2015 at 06:49, Yakir Yang <ykk@rock-chips.com> wrote:
> Split the dp core driver from exynos directory to bridge
> directory, and rename the core driver to analogix_dp_*,
> leave the platform code to analogix_dp-exynos.
>
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> ---
> Changes in v4:
> - Take Rob suggest, update "analogix,hpd-gpios" to "hpd-gpios" DT propery.
> - Take Jingoo suggest, rename "analogix_dp-exynos.c" file name to "exynos_dp.c"
> - Take Archit suggest, create a separate folder for analogix code in bridge/
>
"Take X suggest", is grammatically incorrect. You should use
"suggestion(s)" or alternatively use the following approach.

- Create a separate folder for analogix code in bridge/ (Archit)

Cheers,
Emil

P.S. Why do you resend the whole series (some 10+ patches) when only a
few patches have been changed ? Are all the patches changed whist
missing that information (vX: rebase on top of A)
