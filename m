From: timur@tabi.org (Timur Tabi)
Date: Tue, 12 Nov 2013 14:17:34 -0600
Subject: [alsa-devel] [PATCH] ASoC: fsl-ssi: fix SDMA starvation
In-Reply-To: <20131112132441.GG30263@pengutronix.de>
References: <1384255056-25673-1-git-send-email-mpa@pengutronix.de>
 <52822529.5090502@tabi.org> <20131112132441.GG30263@pengutronix.de>
Message-ID: <CAOZdJXUWv3_ZV6p9VQ+zYqwUDVQC6BMb-VhVoVtEh1yC23VuTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 12, 2013 at 7:24 AM, Markus Pargmann <mpa@pengutronix.de> wrote:
>
> No, I don't have access on PowerPC hardware, so I didn't test it on
> PowerPC.

Can you change the code so that the interrupts are enabled only on
i.MX?  On PowerPC, the interrupts are used only for debugging.
