From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 26 Apr 2011 15:06:30 +0400
Subject: [PATCH v4 03/11] da850: pruss platform specific additions.
In-Reply-To: <1303474109-6212-4-git-send-email-subhasish@mistralsolutions.com>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
	<1303474109-6212-4-git-send-email-subhasish@mistralsolutions.com>
Message-ID: <4DB6A736.3030609@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 22-04-2011 16:08, Subhasish Ghosh wrote:

> This patch adds the platform device and assignes the platform resources
> for the PRUSS mfd driver.

> Signed-off-by: Subhasish Ghosh<subhasish@mistralsolutions.com>

[...]

> diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
> index 09b8ddb..0c23035 100644
> --- a/arch/arm/mach-davinci/include/mach/da8xx.h
> +++ b/arch/arm/mach-davinci/include/mach/da8xx.h
[...]
>   #include<mach/edma.h>
> @@ -73,6 +75,7 @@ extern unsigned int da850_max_speed;
>   #define DA8XX_DDR2_CTL_BASE	0xb0000000
>   #define DA8XX_ARM_RAM_BASE	0xffff0000
>   #define DA8XX_SHARED_RAM_BASE	0x80000000
> +#define DA8XX_PRUSS_MEM_BASE	0x01C30000

    Keep the list sorted please. Also, this macro doesn't seem used outside 
devices-da8xx.c, so should be moved there...

WBR, Sergei
