From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 29 Mar 2016 21:00:22 +0200
Subject: [PATCH] ARM: pxa: fix the number of DMA requestor lines
In-Reply-To: <1457480771-24965-1-git-send-email-robert.jarzmik@free.fr>
 (Robert Jarzmik's message of "Wed, 9 Mar 2016 00:46:11 +0100")
References: <1457480771-24965-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <87k2klqfcp.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> The number of requestor lines was clamped to 0 for all pxa architectures
> in the requestor declaration. Fix this by using the value.
>
> Fixes: 72b195cb7162 ("ARM: pxa: add the number of DMA requestor lines")
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>  arch/arm/mach-pxa/devices.c | 1 +
>  1 file changed, 1 insertion(+)
Queued to pxa/fixes.

-- 
Robert
