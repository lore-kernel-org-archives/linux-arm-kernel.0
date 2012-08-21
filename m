From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Tue, 21 Aug 2012 15:14:19 +0530
Subject: [RFC/PATCH 05/13] serial: omap: drop DMA support
In-Reply-To: <1345540555-24359-6-git-send-email-balbi@ti.com>
References: <1345540555-24359-1-git-send-email-balbi@ti.com>
 <1345540555-24359-6-git-send-email-balbi@ti.com>
Message-ID: <CAMQu2gw93ES=u9J1FfWK_CKkgUq8V487+tmKtQ34p8O7VJ6aHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 21, 2012 at 2:45 PM, Felipe Balbi <balbi@ti.com> wrote:
> The current support is known to be broken and
> a later patch will come re-adding it using
> dma engine API.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
Thanks Felipe !!
One less driver now towards OMAP DMA
engine conversion.

FWIW,
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
