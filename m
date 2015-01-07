From: will.deacon@arm.com (Will Deacon)
Date: Wed, 7 Jan 2015 10:10:56 +0000
Subject: [PATCH v2 31/40] arm64: macro whitespace fixes
In-Reply-To: <1420558883-10131-32-git-send-email-mst@redhat.com>
References: <1420558883-10131-1-git-send-email-mst@redhat.com>
 <1420558883-10131-32-git-send-email-mst@redhat.com>
Message-ID: <20150107101055.GB7485@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 06, 2015 at 03:45:15PM +0000, Michael S. Tsirkin wrote:
> While working on arch/arm64/include/asm/uaccess.h, I noticed
> that one macro within this header is made harder to read because it
> violates a coding style rule: space is missing after comma.
> 
> Fix it up.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---

Acked-by: Will Deacon <will.deacon@arm.com>

Will

>  arch/arm64/include/asm/uaccess.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> index 9a2069b..07e1ba44 100644
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -63,7 +63,7 @@ static inline void set_fs(mm_segment_t fs)
>  	current_thread_info()->addr_limit = fs;
>  }
>  
> -#define segment_eq(a,b)	((a) == (b))
> +#define segment_eq(a, b)	((a) == (b))
>  
>  /*
>   * Return 1 if addr < current->addr_limit, 0 otherwise.
> -- 
> MST
> 
> 
