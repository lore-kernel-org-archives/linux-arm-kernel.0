From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 11 Dec 2015 06:50:12 +0100
Subject: [PATCH] MAINTAINERS: Add missing platform maintainers for dts
 files
In-Reply-To: <1449790703-12054-1-git-send-email-robh@kernel.org> (Rob
 Herring's message of "Thu, 10 Dec 2015 17:38:23 -0600")
References: <1449790703-12054-1-git-send-email-robh@kernel.org>
Message-ID: <87vb85ilez.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Herring <robh@kernel.org> writes:

> Platform dts files need to be reviewed primarily by the platform
> maintainers as dts files typically go in thru their trees. Add the missing
> paths where there are existing maintainers listed.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  MAINTAINERS | 20 +++++++++++++++++++-
...
> @@ -8627,6 +8642,7 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>  T:	git git://github.com/hzhuang1/linux.git
>  T:	git git://github.com/rjarzmik/linux.git
>  S:	Maintained
> +F:	arch/arm/boot/dts/pxa*
>  F:	arch/arm/mach-pxa/
>  F:	drivers/dma/pxa*
>  F:	drivers/pcmcia/pxa2xx*

Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

-- 
Robert
