From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 08 Mar 2011 18:19:23 +0300
Subject: [PATCH v3 3/7] da850: pruss board specific additions.
In-Reply-To: <1299592667-21367-4-git-send-email-subhasish@mistralsolutions.com>
References: <1299592667-21367-1-git-send-email-subhasish@mistralsolutions.com>
	<1299592667-21367-4-git-send-email-subhasish@mistralsolutions.com>
Message-ID: <4D7648FB.9080904@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 08-03-2011 16:57, Subhasish Ghosh wrote:

> This patch adds board specific initializations and setup routines.

> Signed-off-by: Subhasish Ghosh<subhasish@mistralsolutions.com>
[...]

> diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
> index 11f986b..c614c82 100644
> --- a/arch/arm/mach-davinci/board-da850-evm.c
> +++ b/arch/arm/mach-davinci/board-da850-evm.c
> @@ -1053,6 +1053,26 @@ static __init int da850_evm_init_cpufreq(void)
>   static __init int da850_evm_init_cpufreq(void) { return 0; }
>   #endif
>
> +static struct da8xx_pruss_devices pruss_devices[] = {
> +	{.dev_name = NULL,},

    No need to explictly intialize to NULL.

WBR, Sergei
