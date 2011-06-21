From: tushar.behera@linaro.org (Tushar Behera)
Date: Tue, 21 Jun 2011 11:03:12 +0530
Subject: [PATCH v2 1/4] Exynos4 NURI: configure regulators and PMIC
In-Reply-To: <1308622033-2521-2-git-send-email-myungjoo.ham@samsung.com>
References: <20110620103124.GD31864@opensource.wolfsonmicro.com>
	<1308622033-2521-1-git-send-email-myungjoo.ham@samsung.com>
	<1308622033-2521-2-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <4E002D18.2080401@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 June 2011 07:37 AM, MyungJoo Ham wrote:
> Signed-off-by: MyungJoo Ham<myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park<kyungmin.park@samsung.com>
>
> --
> Changes from v1. Thanks so much for your valuable comments, Mark.
> - Removed unnecessary initialization data
> - Add __initdata where necessary
> - Corrected a regulator name for ADC
> ---
>   arch/arm/mach-exynos4/mach-nuri.c |  622 ++++++++++++++++++++++++++++++++++++-
>   1 files changed, 621 insertions(+), 1 deletions(-)
>
Will it be possible to move PMIC specific defines to a common file and 
make appropriate calls in the board-specific file?

In that way, we can re-use this PMIC code on some other boards (e.g. 
Insignal low-cost board Origen featuring Exynos4210 also features MAX8997).


-- 
Tushar Behera
