From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 19 Jun 2015 21:16:50 +0200
Subject: [PATCH v2] ARM: pxa: transition to dmaengine phase 1
In-Reply-To: <1433625062-28306-1-git-send-email-robert.jarzmik@free.fr>
 (Robert Jarzmik's message of "Sat, 6 Jun 2015 23:11:02 +0200")
References: <1433625062-28306-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <87h9q3a4pp.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> In order to slowly transition pxa to dmaengine, the legacy code will now
> rely on dmaengine to request a channel.
>
> This implies that PXA architecture selects DMADEVICES and PXA_DMA,
> which is not pretty. Yet it enables PXA drivers to be ported one by one,
> with part of them using dmaengine, and the other part using the legacy
> code.
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Queued into pxa/for-next.

--
Robert
