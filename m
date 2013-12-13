From: ynvich@gmail.com (Sergei Ianovich)
Date: Fri, 13 Dec 2013 06:33:43 +0400
Subject: [PATCH v2 00/16] ARM: support for ICP DAS LP-8x4x (with dts)
In-Reply-To: <1386901645-28895-1-git-send-email-ynvich@gmail.com>
References: <1386543229-1542-1-git-send-email-ynvich@gmail.com>
 <1386901645-28895-1-git-send-email-ynvich@gmail.com>
Message-ID: <1386902023.7152.290.camel@host5.omatika.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-12-13 at 06:27 +0400, Sergei Ianovich wrote:
> Fixed most review requirements. Details in respective patches.
> 
> I've completely met the requirement for using dmaengine-based DMA
> in patch v2-03/16. Tests showed new DMA was underperforming. It added
> on top of a pre-existing problem with MMC bus width and made the system
> barely usable. However, the new code in this patch work correctly with
> both the existing and the new DMA. Even if the new DMA is compiled into
> the kernel, the exisitng DMA initializes first.

s/I've/I've not/
