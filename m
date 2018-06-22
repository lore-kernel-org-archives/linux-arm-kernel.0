From: vkoul@kernel.org (Vinod)
Date: Fri, 22 Jun 2018 09:54:07 +0530
Subject: [PATCH 1/2] hwrng: msm: add a spinlock and support for blocking
 reads
In-Reply-To: <efc93d58-4671-2c51-75d4-a19759ab0f0c@codeaurora.org>
References: <1529594276-12210-1-git-send-email-timur@codeaurora.org>
 <20180622041712.GE27187@vkoul-mobl>
 <efc93d58-4671-2c51-75d4-a19759ab0f0c@codeaurora.org>
Message-ID: <20180622042407.GG27187@vkoul-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21-06-18, 23:18, Timur Tabi wrote:
> On 6/21/18 11:17 PM, Vinod wrote:
> > this should be a separate patch
> 
> What exactly should be a separate patch?  This part?
> 
> -	rng->hwrng.name = KBUILD_MODNAME,
> -	rng->hwrng.init = msm_rng_init,
> -	rng->hwrng.cleanup = msm_rng_cleanup,
> -	rng->hwrng.read = msm_rng_read,
> +	rng->hwrng.name = KBUILD_MODNAME;
> +	rng->hwrng.init = msm_rng_init;
> +	rng->hwrng.cleanup = msm_rng_cleanup;
> +	rng->hwrng.read = msm_rng_read;

yes

-- 
~Vinod
