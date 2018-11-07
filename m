From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 7 Nov 2018 09:18:55 +0000
Subject: [PATCH]  arm64: fix commit style in the comments
In-Reply-To: <1541605151-6757-1-git-send-email-peng.hao2@zte.com.cn>
References: <1541605151-6757-1-git-send-email-peng.hao2@zte.com.cn>
Message-ID: <20181107091855.ps5pumxp7djtfz3k@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 07, 2018 at 11:39:11PM +0800, Peng Hao wrote:
> Use git commit description style 'commit <12+ chars of sha1>
> ("<title line>")' in the comments.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  arch/arm64/kernel/sys32.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/sys32.c b/arch/arm64/kernel/sys32.c
> index 0f8bcb7..8317a5a 100644
> --- a/arch/arm64/kernel/sys32.c
> +++ b/arch/arm64/kernel/sys32.c
> @@ -40,8 +40,8 @@
>  	 * arbitrary binaries may rely upon it, so we must do the same.
>  	 * For more details, see commit:
>  	 *
> -	 * 713c481519f19df9 ("[ARM] 3108/2: old ABI compat: statfs64 and
> -	 * fstatfs64")
> +	 * commit 713c481519f19df9 ("[ARM] 3108/2: old ABI compat: statfs64
> +	 * and fstatfs64")

Seriously, how does this help? It already states "see commit:" on the
previous line.

-- 
Catalin
