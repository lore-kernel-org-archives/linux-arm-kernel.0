From: inki.dae@samsung.com (Inki Dae)
Date: Mon, 12 Oct 2015 22:35:11 +0900
Subject: [PATCH] drm/exynos: fix spelling errors
In-Reply-To: <1443776366-13046-1-git-send-email-ingi2.kim@samsung.com>
References: <1443776366-13046-1-git-send-email-ingi2.kim@samsung.com>
Message-ID: <561BB70F.9080306@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Ingi.

Merged. Thanks for your first patch to drm world. :)
This patch isn't trivial so will go to next.

Thanks,
Inki Dae


2015? 10? 02? 17:59? Ingi Kim ?(?) ? ?:
> This patch fixes spelling errors in drm fimc/gsc
> inavild -> invaild
> 
> Signed-off-by: Ingi Kim <ingi2.kim@samsung.com>
> ---
>   drivers/gpu/drm/exynos/exynos_drm_fimc.c | 16 ++++++++--------
>   drivers/gpu/drm/exynos/exynos_drm_gsc.c  | 12 ++++++------
>   2 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimc.c b/drivers/gpu/drm/exynos/exynos_drm_fimc.c
> index 2a65235..5d00f86 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_fimc.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_fimc.c
> @@ -466,7 +466,7 @@ static int fimc_src_set_fmt_order(struct fimc_context *ctx, u32 fmt)
>   			EXYNOS_MSCTRL_C_INT_IN_2PLANE);
>   		break;
>   	default:
> -		dev_err(ippdrv->dev, "inavlid source yuv order 0x%x.\n", fmt);
> +		dev_err(ippdrv->dev, "invalid source yuv order 0x%x.\n", fmt);
>   		return -EINVAL;
>   	}
>   
> @@ -513,7 +513,7 @@ static int fimc_src_set_fmt(struct device *dev, u32 fmt)
>   		cfg |= EXYNOS_MSCTRL_INFORMAT_YCBCR420;
>   		break;
>   	default:
> -		dev_err(ippdrv->dev, "inavlid source format 0x%x.\n", fmt);
> +		dev_err(ippdrv->dev, "invalid source format 0x%x.\n", fmt);
>   		return -EINVAL;
>   	}
>   
> @@ -578,7 +578,7 @@ static int fimc_src_set_transf(struct device *dev,
>   			cfg1 &= ~EXYNOS_MSCTRL_FLIP_Y_MIRROR;
>   		break;
>   	default:
> -		dev_err(ippdrv->dev, "inavlid degree value %d.\n", degree);
> +		dev_err(ippdrv->dev, "invalid degree value %d.\n", degree);
>   		return -EINVAL;
>   	}
>   
> @@ -701,7 +701,7 @@ static int fimc_src_set_addr(struct device *dev,
>   		property->prop_id, buf_id, buf_type);
>   
>   	if (buf_id > FIMC_MAX_SRC) {
> -		dev_info(ippdrv->dev, "inavlid buf_id %d.\n", buf_id);
> +		dev_info(ippdrv->dev, "invalid buf_id %d.\n", buf_id);
>   		return -ENOMEM;
>   	}
>   
> @@ -812,7 +812,7 @@ static int fimc_dst_set_fmt_order(struct fimc_context *ctx, u32 fmt)
>   		cfg |= EXYNOS_CIOCTRL_YCBCR_2PLANE;
>   		break;
>   	default:
> -		dev_err(ippdrv->dev, "inavlid target yuv order 0x%x.\n", fmt);
> +		dev_err(ippdrv->dev, "invalid target yuv order 0x%x.\n", fmt);
>   		return -EINVAL;
>   	}
>   
> @@ -865,7 +865,7 @@ static int fimc_dst_set_fmt(struct device *dev, u32 fmt)
>   			cfg |= EXYNOS_CITRGFMT_OUTFORMAT_YCBCR420;
>   			break;
>   		default:
> -			dev_err(ippdrv->dev, "inavlid target format 0x%x.\n",
> +			dev_err(ippdrv->dev, "invalid target format 0x%x.\n",
>   				fmt);
>   			return -EINVAL;
>   		}
> @@ -929,7 +929,7 @@ static int fimc_dst_set_transf(struct device *dev,
>   			cfg &= ~EXYNOS_CITRGFMT_FLIP_Y_MIRROR;
>   		break;
>   	default:
> -		dev_err(ippdrv->dev, "inavlid degree value %d.\n", degree);
> +		dev_err(ippdrv->dev, "invalid degree value %d.\n", degree);
>   		return -EINVAL;
>   	}
>   
> @@ -1160,7 +1160,7 @@ static int fimc_dst_set_addr(struct device *dev,
>   		property->prop_id, buf_id, buf_type);
>   
>   	if (buf_id > FIMC_MAX_DST) {
> -		dev_info(ippdrv->dev, "inavlid buf_id %d.\n", buf_id);
> +		dev_info(ippdrv->dev, "invalid buf_id %d.\n", buf_id);
>   		return -ENOMEM;
>   	}
>   
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_gsc.c b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
> index 808a0a0..11b87d2 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_gsc.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
> @@ -543,7 +543,7 @@ static int gsc_src_set_fmt(struct device *dev, u32 fmt)
>   			GSC_IN_YUV420_2P);
>   		break;
>   	default:
> -		dev_err(ippdrv->dev, "inavlid target yuv order 0x%x.\n", fmt);
> +		dev_err(ippdrv->dev, "invalid target yuv order 0x%x.\n", fmt);
>   		return -EINVAL;
>   	}
>   
> @@ -595,7 +595,7 @@ static int gsc_src_set_transf(struct device *dev,
>   			cfg &= ~GSC_IN_ROT_YFLIP;
>   		break;
>   	default:
> -		dev_err(ippdrv->dev, "inavlid degree value %d.\n", degree);
> +		dev_err(ippdrv->dev, "invalid degree value %d.\n", degree);
>   		return -EINVAL;
>   	}
>   
> @@ -721,7 +721,7 @@ static int gsc_src_set_addr(struct device *dev,
>   		property->prop_id, buf_id, buf_type);
>   
>   	if (buf_id > GSC_MAX_SRC) {
> -		dev_info(ippdrv->dev, "inavlid buf_id %d.\n", buf_id);
> +		dev_info(ippdrv->dev, "invalid buf_id %d.\n", buf_id);
>   		return -EINVAL;
>   	}
>   
> @@ -814,7 +814,7 @@ static int gsc_dst_set_fmt(struct device *dev, u32 fmt)
>   			GSC_OUT_YUV420_2P);
>   		break;
>   	default:
> -		dev_err(ippdrv->dev, "inavlid target yuv order 0x%x.\n", fmt);
> +		dev_err(ippdrv->dev, "invalid target yuv order 0x%x.\n", fmt);
>   		return -EINVAL;
>   	}
>   
> @@ -866,7 +866,7 @@ static int gsc_dst_set_transf(struct device *dev,
>   			cfg &= ~GSC_IN_ROT_YFLIP;
>   		break;
>   	default:
> -		dev_err(ippdrv->dev, "inavlid degree value %d.\n", degree);
> +		dev_err(ippdrv->dev, "invalid degree value %d.\n", degree);
>   		return -EINVAL;
>   	}
>   
> @@ -1176,7 +1176,7 @@ static int gsc_dst_set_addr(struct device *dev,
>   		property->prop_id, buf_id, buf_type);
>   
>   	if (buf_id > GSC_MAX_DST) {
> -		dev_info(ippdrv->dev, "inavlid buf_id %d.\n", buf_id);
> +		dev_info(ippdrv->dev, "invalid buf_id %d.\n", buf_id);
>   		return -EINVAL;
>   	}
>   
> 
