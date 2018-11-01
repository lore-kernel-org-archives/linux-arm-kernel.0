From: will.deacon@arm.com (Will Deacon)
Date: Thu, 1 Nov 2018 23:01:13 +0000
Subject: [PATCH] arm64: kdump: fix small typo
In-Reply-To: <20181101152531.22489-1-tiny.windzz@gmail.com>
References: <20181101152531.22489-1-tiny.windzz@gmail.com>
Message-ID: <20181101230112.GB24757@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 01, 2018 at 11:25:31AM -0400, Yangtao Li wrote:
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  arch/arm64/kernel/crash_dump.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/crash_dump.c b/arch/arm64/kernel/crash_dump.c
> index f46d57c31443..6b5037ed15b2 100644
> --- a/arch/arm64/kernel/crash_dump.c
> +++ b/arch/arm64/kernel/crash_dump.c
> @@ -58,7 +58,7 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
>  /**
>   * elfcorehdr_read - read from ELF core header
>   * @buf: buffer where the data is placed
> - * @csize: number of bytes to read
> + * @count: number of bytes to read

I know this is trivial, but please can you include a short commit message
saying that this brings the kerneldoc in line with the function signature?

Thanks,

Will
