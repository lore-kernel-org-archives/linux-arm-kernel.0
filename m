From: manabian@gmail.com (Joachim Eastwood)
Date: Fri, 23 Nov 2012 17:04:42 +0100
Subject: [PATCH] net/macb: GEM DMA configuration register update
In-Reply-To: <1353678541-26839-1-git-send-email-nicolas.ferre@atmel.com>
References: <1353678541-26839-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <CAGhQ9Vw=Yk7RAMVsBM71QWNjsD99PnrTgRs5+pK8V2e=HirQqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 November 2012 14:49, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> Add information to the DMA Configuration Register to
> maximize system performance:
> - rx/tx packet buffer full memory size
> - allow possibility to use INCR16 if supported
>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Acked-by: Joachim Eastwood <manabian@gmail.com

regards
Joachim Eastwood
