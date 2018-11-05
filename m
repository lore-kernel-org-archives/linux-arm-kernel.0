From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 05 Nov 2018 23:36:32 +0100
Subject: [PATCH RESEND] dmaengine: pxa: make the filter function internal
In-Reply-To: <20181105194503.25639-1-daniel@zonque.org> (Daniel Mack's message
 of "Mon, 5 Nov 2018 20:45:03 +0100")
References: <20181105194503.25639-1-daniel@zonque.org>
Message-ID: <874lcvm9sf.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Mack <daniel@zonque.org> writes:

> From: Robert Jarzmik <robert.jarzmik@free.fr>
>
> As the pxa architecture and all its related drivers do not rely anymore
> on the filter function, thanks to the slave map conversion, make
> pxad_filter_fn() static, and remove it from the global namespace.
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Acked-by: Vinod Koul <vkoul@kernel.org>
> ---
>
> I'm resending this as it appears to be the last patch that's missing
> from the PXA DMA transition series.
>
> Robert, any reason why it wasn't applied?
Ah this is because my pull request was ... not taken into account.

Arnd, Kevin, Olof, did you receive this
https://www.spinics.net/lists/arm-kernel/msg679383.html ? It might be my mailer
getting me into trouble once more.

Cheers.

--
Robert
