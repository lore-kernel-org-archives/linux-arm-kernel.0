From: xuwei5@hisilicon.com (Wei Xu)
Date: Thu, 19 Nov 2015 16:50:19 +0000
Subject: [PATCH 1/2] ARM: hisi: do not export smp_operations structures
In-Reply-To: <1447551593-22246-2-git-send-email-yamada.masahiro@socionext.com>
References: <1447551593-22246-1-git-send-email-yamada.masahiro@socionext.com>
 <1447551593-22246-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <564DFDCB.2070906@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Masahiro,

On 15/11/2015 01:39, Masahiro Yamada wrote:
> These three structures are only defined and referenced in
> mach-hisi/platsmp.c.
> 
> Drop the declarations from the header and add static qualifier
> to the definitions.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Thanks!
Acked-by: Wei Xu <xuwei5@hisilicon.com>

Best Regards,
Wei
