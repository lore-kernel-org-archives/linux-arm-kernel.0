From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 4 Mar 2014 09:55:36 +0000
Subject: [PATCH v2] arm64: topology: Implement basic CPU topology support
In-Reply-To: <1393919477-27814-1-git-send-email-broonie@kernel.org>
References: <1393919477-27814-1-git-send-email-broonie@kernel.org>
Message-ID: <20140304095534.GE30596@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 04, 2014 at 07:51:17AM +0000, Mark Brown wrote:
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 764d682..80e0eb1 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -165,6 +165,30 @@ config SMP
>  
>  	  If you don't know what to do here, say N.
>  
> +config CPU_TOPOLOGY
> +	bool "Support CPU topology definition"

Thanks for the patch. I applied it but not pushed to -next yet. I wonder
whether it makes sense to drop the description of the CPU_TOPOLOGY entry
here so that it is no longer selectable. It will be enabled by default
when SMP (I can do the change myself, no need to repost).

-- 
Catalin
