From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 07 Feb 2012 10:35:24 +0100
Subject: [PATCH 3/3] ARM: remove empty disable_fiq and arch_ret_to_user
 macros
In-Reply-To: <1328562200-8810-4-git-send-email-robherring2@gmail.com>
References: <1328562200-8810-1-git-send-email-robherring2@gmail.com>
 <1328562200-8810-4-git-send-email-robherring2@gmail.com>
Message-ID: <4F30F05C.6070400@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/06/2012 10:03 PM, Rob Herring :
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Now that most platforms don't need disable_fiq and arch_ret_to_user
> macros, we can remove the empty macros or empty entry-macro.S files.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
>  arch/arm/mach-at91/include/mach/entry-macro.S      |    6 ----

For AT91:

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

[..]

Best regards,
-- 
Nicolas Ferre
