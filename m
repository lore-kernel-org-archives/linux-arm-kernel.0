From: javier.martin@vista-silicon.com (javier Martin)
Date: Tue, 14 Feb 2012 12:51:41 +0100
Subject: [PATCH 0/4] dmaengine: i.MX DMA series.
In-Reply-To: <1328884300-18801-1-git-send-email-javier.martin@vista-silicon.com>
References: <1328884300-18801-1-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <CACKLOr1Gn_NR8HPhmyK6DW9W+7CGG8y7yoZm6PE3bH2zt6Ej-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 February 2012 15:31, Javier Martin
<javier.martin@vista-silicon.com> wrote:
> Patches 1-3 have already been sent to the list (not merged yet)
> but they are submitted so that everyone can get the whole picture
> of what we're trying to do here.
>
> A new patch(4) has been added which adds support for multiple
> descriptors.
>
> [PATCH 1/4] dmaengine: Add support for MEMCPY for imx-dma.
> [PATCH 2/4] i.MX DMA: Add support for 2D transfers.
> [PATCH 3/4] dmaengine: i.MX: Add support for interleaved transfers.
> [PATCH 4/4] dmaengine: Add support for multiple descriptors for imx-dma.

Hi,
what do you think of this series?

Vinod: your concern about patch 1 is solved in patch 4
Sascha: I know you are not comfortable with patch 2 since it adds code
to a file which is meant to be removed. However, is there a chance you
accept it without me having to rewrite the whole series?

Regards.
-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
