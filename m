From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 11 Dec 2015 11:47:04 +0100
Subject: [PATCH] MAINTAINERS: Add missing platform maintainers for dts
 files
In-Reply-To: <1449790703-12054-1-git-send-email-robh@kernel.org>
References: <1449790703-12054-1-git-send-email-robh@kernel.org>
Message-ID: <566AA9A8.3010707@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11.12.2015 00:38, Rob Herring wrote:
> Platform dts files need to be reviewed primarily by the platform
> maintainers as dts files typically go in thru their trees. Add the missing
> paths where there are existing maintainers listed.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   MAINTAINERS | 20 +++++++++++++++++++-
>   1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 69c8a9c..415b731 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
[...]
> @@ -1270,6 +1278,7 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>   S:	Maintained
>   F:	arch/arm/mach-berlin/
>   F:	arch/arm/boot/dts/berlin*
> +F:	arch/arm64/boot/dts/marvell/berlin*

For Berlin,

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Thanks!
