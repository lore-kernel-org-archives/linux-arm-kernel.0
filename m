From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 27 Jul 2018 12:43:44 +0100
Subject: [PATCH v5 3/3] arm64: Introduce command line parameter to
 disable CNP
In-Reply-To: <1529403502-2843-4-git-send-email-vladimir.murzin@arm.com>
References: <1529403502-2843-1-git-send-email-vladimir.murzin@arm.com>
 <1529403502-2843-4-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20180727114343.ied4vfi2ljdgli2s@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2018 at 11:18:22AM +0100, Vladimir Murzin wrote:
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2648,6 +2648,10 @@
>  
>  	noclflush	[BUGS=X86] Don't use the CLFLUSH instruction
>  
> +	nocnp		[ARM64]
> +			Disable CNP (Common not Private translations)
> +			even if it is supported by processor.
> +
>  	nodelayacct	[KNL] Disable per-task delay accounting
>  
>  	nodsp		[SH] Disable hardware DSP at boot time.

I'll leave the decision to Will here. As I commented on a previous
version, I'm not particularly fond of new command like options.

-- 
Catalin
