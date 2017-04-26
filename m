From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 26 Apr 2017 09:22:29 +0200
Subject: [PATCH] arm64: dts: exynos: Remove the te-gpios property in the
 TM2 boards
In-Reply-To: <1493085261-3488-1-git-send-email-hoegeun.kwon@samsung.com>
References: <CGME20170425015437epcas5p43549d47e69519f43d89ba2de496ba451@epcas5p4.samsung.com>
 <1493085261-3488-1-git-send-email-hoegeun.kwon@samsung.com>
Message-ID: <CAJKOXPf+5+ENdh1aOa8JER6NEvYch9W1B0xuXiijNeKWh6R_SQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 25, 2017 at 3:54 AM, Hoegeun Kwon <hoegeun.kwon@samsung.com> wrote:
> The decon uses HW-TRIGGER, so TE interrupt is not necessary.
> Therefore, remove the te-gpios property in the TM2 dts.
>
> Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433-tm2.dts | 1 -
>  1 file changed, 1 deletion(-)
>

Looks correct. It is too late for me for v4.12 so I will pick it up
for v4.13. For my reference:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
