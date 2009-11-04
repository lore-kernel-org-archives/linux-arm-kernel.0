From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 4 Nov 2009 22:35:33 +0800
Subject: [PATCH] [ARM] pxa: add U2D registers and bits definitions
In-Reply-To: <1257336880-16011-2-git-send-email-grinberg@compulab.co.il>
References: <1257336880-16011-1-git-send-email-grinberg@compulab.co.il>
	<1257336880-16011-2-git-send-email-grinberg@compulab.co.il>
Message-ID: <f17812d70911040635o1ab53e64s255d031db0de6091@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 4, 2009 at 8:14 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
>
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> ---
> ?arch/arm/mach-pxa/include/mach/regs-u2d.h | ?199 +++++++++++++++++++++++++++++
> ?1 files changed, 199 insertions(+), 0 deletions(-)
> ?create mode 100644 arch/arm/mach-pxa/include/mach/regs-u2d.h
>
> diff --git a/arch/arm/mach-pxa/include/mach/regs-u2d.h b/arch/arm/mach-pxa/include/mach/regs-u2d.h

Unless there are registers shared between drivers and platform code,
I'd rather this been kept closer to the driver, include/mach/* is already
pretty crowded :)
