From: rdunlap@infradead.org (Randy Dunlap)
Date: Thu, 2 Mar 2017 15:53:35 -0800
Subject: [RFC v0 1/2] interconnect: Add generic interconnect controller API
In-Reply-To: <20170301182235.19154-2-georgi.djakov@linaro.org>
References: <20170301182235.19154-1-georgi.djakov@linaro.org>
 <20170301182235.19154-2-georgi.djakov@linaro.org>
Message-ID: <15929d7a-65e5-f8ba-2fac-0381c5f8e8fc@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/01/17 10:22, Georgi Djakov wrote:
> 
> diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
> new file mode 100644
> index 000000000000..103524b59905
> --- /dev/null
> +++ b/drivers/interconnect/Kconfig
> @@ -0,0 +1,10 @@
> +menuconfig INTERCONNECT
> +	bool "On-Chip Interconnect management support"

Why isn't this symbol tristate instead of bool so that the
interconnect management support can be built as a loadable module?


> +	help
> +	  Support for management of the on-chip interconnects.
> +
> +	  This framework is designed to provide a generic interface for
> +          managing the interconnects in a SoC.
> +
> +	  If unsure, say no.
> +


-- 
~Randy
