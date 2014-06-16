From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 16 Jun 2014 10:26:31 +0100
Subject: [PATCH] [linux-next] arm64: ftrace: Fix comment typo
 'CONFIG_FUNCTION_GRAPH_FP_TEST'
In-Reply-To: <1402479861.3798.63.camel@x220>
References: <1402479861.3798.63.camel@x220>
Message-ID: <20140616092630.GA3971@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 11, 2014 at 10:44:21AM +0100, Paul Bolle wrote:
> diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
> index b051871f2965..aa5f9fcbf9ee 100644
> --- a/arch/arm64/kernel/entry-ftrace.S
> +++ b/arch/arm64/kernel/entry-ftrace.S
> @@ -205,7 +205,7 @@ ENDPROC(ftrace_graph_caller)
>   *
>   * Run ftrace_return_to_handler() before going back to parent.
>   * @fp is checked against the value passed by ftrace_graph_caller()
> - * only when CONFIG_FUNCTION_GRAPH_FP_TEST is enabled.
> + * only when CONFIG_HAVE_FUNCTION_GRAPH_FP_TEST is enabled.
>   */
>  ENTRY(return_to_handler)
>  	str	x0, [sp, #-16]!

Thanks. Applied.

-- 
Catalin
