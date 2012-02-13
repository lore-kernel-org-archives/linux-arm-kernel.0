From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Mon, 13 Feb 2012 15:00:04 +0400
Subject: [PATCH 6/7] Add hugetlb Kconfig option
In-Reply-To: <1329126268-11032-7-git-send-email-bill4carson@gmail.com>
References: <1329126268-11032-1-git-send-email-bill4carson@gmail.com>
 <1329126268-11032-7-git-send-email-bill4carson@gmail.com>
Message-ID: <4F38ED34.1030300@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 13-02-2012 13:44, Bill Carson wrote:

> Signed-off-by: Bill Carson<bill4carson@gmail.com>
> ---
>   arch/arm/Kconfig |   29 +++++++++++++++++++++++++++++
>   1 files changed, 29 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index a48aecc..161bca6 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -985,6 +985,35 @@ config ARCH_ZYNQ
>   	  Support for Xilinx Zynq ARM Cortex A9 Platform
>   endchoice
>
> +config SYS_SUPPORTS_HUGETLBFS
> +		def_bool n

    This is probably overindented.

WBR, Sergei
