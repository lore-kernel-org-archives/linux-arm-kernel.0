From: rkuo@codeaurora.org (Richard Kuo)
Date: Mon, 8 Jan 2018 21:13:39 -0600
Subject: [PATCH 06/67] hexagon: remove unused flush_write_buffers
 definition
In-Reply-To: <20171229081911.2802-7-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
 <20171229081911.2802-7-hch@lst.de>
Message-ID: <20180109031339.GA4196@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 29, 2017 at 09:18:10AM +0100, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/hexagon/include/asm/io.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/io.h
> index 66f5e9a61efc..9e8621d94ee9 100644
> --- a/arch/hexagon/include/asm/io.h
> +++ b/arch/hexagon/include/asm/io.h
> @@ -330,8 +330,6 @@ static inline void outsl(unsigned long port, const void *buffer, int count)
>  	}
>  }
>  
> -#define flush_write_buffers() do { } while (0)
> -
>  #endif /* __KERNEL__ */
>  
>  #endif
> -- 
> 2.14.2
> 

For Hexagon:

Acked-by: Richard Kuo <rkuo@codeaurora.org>


-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
