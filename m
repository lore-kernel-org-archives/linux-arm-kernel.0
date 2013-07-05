From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 06 Jul 2013 01:45:48 +0200
Subject: [PATCH] drm/exynos: exynos_drm_ipp: fix return value check
In-Reply-To: <CAPgLHd9yE7YES-yDFSWfHOKbbay2yLS_VrvF5-QyJumnNFitQw@mail.gmail.com>
References: <CAPgLHd9yE7YES-yDFSWfHOKbbay2yLS_VrvF5-QyJumnNFitQw@mail.gmail.com>
Message-ID: <1543220.nCniYjBE9B@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 of July 2013 21:35:00 Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function ipp_find_obj() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check
> should be replaced with IS_ERR().
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_ipp.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
