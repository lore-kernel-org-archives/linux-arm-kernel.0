From: woogyom.kim@gmail.com (Milo Kim)
Date: Wed, 24 Aug 2016 16:14:53 +0900
Subject: [PATCH v2 1/4] ARM: dts: exynos: Enable HDMI for Arndale Octa
 board
In-Reply-To: <7c58bbae-91ce-a6e7-14be-282b6fa40e42@samsung.com>
References: <1472005524-3489-1-git-send-email-woogyom.kim@gmail.com>
 <1472005524-3489-2-git-send-email-woogyom.kim@gmail.com>
 <7c58bbae-91ce-a6e7-14be-282b6fa40e42@samsung.com>
Message-ID: <ba7795e3-164f-640b-3631-bce3edd97b6e@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrzej,

On 08/24/2016 02:28 PM, Andrzej Hajda wrote:
> Please use ddc property in hdmi node, instead of this legacy binding.
> See exynos4210-universal_c210.dts or exynos4412-odroid-common.dtsi for
> reference.

Cool! I prefer this simple property. Thanks for the review.

Best regards,
Milo
