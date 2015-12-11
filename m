From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 11 Dec 2015 07:13:44 +0530
Subject: [PATCH] MAINTAINERS: Add missing platform maintainers for dts
 files
In-Reply-To: <1449790703-12054-1-git-send-email-robh@kernel.org>
References: <1449790703-12054-1-git-send-email-robh@kernel.org>
Message-ID: <20151211014344.GG3612@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10-12-15, 17:38, Rob Herring wrote:
> Platform dts files need to be reviewed primarily by the platform
> maintainers as dts files typically go in thru their trees. Add the missing
> paths where there are existing maintainers listed.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  MAINTAINERS | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> @@ -10068,6 +10085,7 @@ L:	spear-devel at list.st.com
>  L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>  W:	http://www.st.com/spear
>  S:	Maintained
> +F:	arch/arm/boot/dts/spear*
>  F:	arch/arm/mach-spear/
>  
>  SPEAR CLOCK FRAMEWORK SUPPORT

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
