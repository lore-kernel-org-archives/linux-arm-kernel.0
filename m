From: adharmap@codeaurora.org (Abhijeet Dharmapurikar)
Date: Tue, 30 Nov 2010 17:08:17 -0800
Subject: [PATCH 03/54] ARM: gic: irq_data conversion.
In-Reply-To: <20101130132536.GD15575@mail.wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
	<20101130132536.GD15575@mail.wantstofly.org>
Message-ID: <4CF5A001.8080906@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Works on msm 8660 surf.

Acked-by: Abhijeet Dharmapurikar <adharmap@codeaurora.org>

Lennert Buytenhek wrote:
> Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
> ---
>  arch/arm/common/gic.c |   62 ++++++++++++++++++++++++------------------------
>  1 files changed, 31 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
> index 772f95f..1118f40 100644
> --- a/arch/arm/common/gic.c
> +++ b/arch/arm/common/gic.c
> @@ -47,57 +47,56 @@ struct gic_chip_data {
>  
