From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 29 Jan 2015 20:43:50 +0100
Subject: [RESEND PATCH v4] Sound: PXA: Fix settings of PXAxxx DMA
In-Reply-To: <54CA2B7E.5010003@tul.cz> (Petr Cvek's message of "Thu, 29 Jan
 2015 13:45:50 +0100")
References: <54CA125D.7010908@tul.cz> <54CA2B7E.5010003@tul.cz>
Message-ID: <87bnlhnzih.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> Fix PXA DMA autoincrementation, so capture will not use playback settings
> (incrementation in register space instead in target buffer).
>
> Regression from:
>   'commit d65a14587a9be853a887a1407db133df1fb68e29 ("ASoC: pxa: use snd_dmaengine_dai_dma_data")'
>
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
> Acked-by: Daniel Mack <daniel@zonque.org>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

--
Robert
