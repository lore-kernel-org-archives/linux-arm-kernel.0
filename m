From: rmallon@gmail.com (Ryan Mallon)
Date: Tue, 07 Feb 2012 09:22:52 +1100
Subject: [PATCH 0/3] entry-macro.S clean-up
In-Reply-To: <1328562200-8810-1-git-send-email-robherring2@gmail.com>
References: <1328562200-8810-1-git-send-email-robherring2@gmail.com>
Message-ID: <4F3052BC.2050505@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/02/12 08:03, Rob Herring wrote:

> From: Rob Herring <rob.herring@calxeda.com>
> 
> With the recent MULTI_IRQ_HANDLER support, many of the platform
> entry-macro.S files can be removed. This series removes empty
> isable_fiq and arch_ret_to_user macros from most platforms.
> 
> This leaves rpc, iop13xx, iop32x and iop33x with compile time
> difference from other platforms.
> 
> Rob
> 
> Rob Herring (3):
>   ARM: make arch_ret_to_user macro optional
>   ARM: make disable_fiq macro optional
>   ARM: remove empty disable_fiq and arch_ret_to_user macros
> 


<snip>

>  arch/arm/mach-ep93xx/include/mach/entry-macro.S    |   17 ------------


Build tested only, but looks correct to me. For ep93xx:

Acked-by: Ryan Mallon <rmallon@gmail.com>
