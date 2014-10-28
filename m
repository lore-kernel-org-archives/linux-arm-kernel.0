From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 28 Oct 2014 15:18:48 +0100
Subject: [PATCH v2 1/5] ARM: introduce a CONFIG_ARCH_MULTIPLATFORM_STRICT
 Kconfig option
In-Reply-To: <1414503095-25986-2-git-send-email-kaixu.xia@linaro.org>
References: <1414503095-25986-1-git-send-email-kaixu.xia@linaro.org>
 <1414503095-25986-2-git-send-email-kaixu.xia@linaro.org>
Message-ID: <71099905.SGyci24BjF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 28 October 2014 21:31:31 Xia Kaixu wrote:
>  endmenu
>  
> +config ARCH_MULTIPLATFORM_STRICT
> +        bool "Only allow options that do not break other platforms"
> +        depends on ARCH_MULTIPLATFORM
> +        default y
> +       help
> +          There are several configuration options that can only work
> 

Something seems to be wrong with the whitespace here. Please use tab
characters for indentation like we do elsewhere in the file.

Otherwise looks good, I think this is a good step in the right direction.

	Arnd
