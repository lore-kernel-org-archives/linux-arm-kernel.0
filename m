From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Sun, 19 Aug 2012 22:32:19 +0300
Subject: [PATCH 3/8] UBI: introduce MTD_PARAM_MAX_COUNT
In-Reply-To: <1345214124-5478-4-git-send-email-richard.genoud@gmail.com>
References: <1345214124-5478-1-git-send-email-richard.genoud@gmail.com>
 <1345214124-5478-4-git-send-email-richard.genoud@gmail.com>
Message-ID: <1345404739.1930.11.camel@kyv>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-08-17 at 16:35 +0200, Richard Genoud wrote:
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> ---
>  drivers/mtd/ubi/build.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
> index 82d11e1..1f45f51 100644
> --- a/drivers/mtd/ubi/build.c
> +++ b/drivers/mtd/ubi/build.c
> @@ -46,6 +46,9 @@
>  /* Maximum length of the 'mtd=' parameter */
>  #define MTD_PARAM_LEN_MAX 64
>  
> +/* Maximum number of comma-separated items in ht 'mtd=' parameter */
> +#define MTD_PARAM_MAX_COUNT 2

Fixed the spelling of "the" and pushed to linux-ubi.git, thanks!

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120819/43454bc0/attachment.sig>
