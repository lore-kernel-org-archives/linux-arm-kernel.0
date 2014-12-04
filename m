From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 04 Dec 2014 22:18:19 +0100
Subject: [PATCH] arm: pxa: fix pxa27x device-tree support kconfig
In-Reply-To: <1417206768-5840-1-git-send-email-robert.jarzmik@free.fr> (Robert
 Jarzmik's message of "Fri, 28 Nov 2014 21:32:48 +0100")
References: <1417206768-5840-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <87a933yuzo.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> Remove the useless CPU_PXA27x non existing kconfig option.
> The true options is PXA27x, which is already selected.
>
> Reported-by: Paul Bolle <pebolle@tiscali.nl>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>

Queued to pxa/for-next.

-- 
Robert
