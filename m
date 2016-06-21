From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 21 Jun 2016 16:04:57 +0800
Subject: [PATCH] ARM: i.MX: Fix FIQ interrupt handling for TZIC
In-Reply-To: <1466319353-19559-1-git-send-email-shc_work@mail.ru>
References: <1466319353-19559-1-git-send-email-shc_work@mail.ru>
Message-ID: <20160621080457.GH21364@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 19, 2016 at 09:55:53AM +0300, Alexander Shiyan wrote:
> IRQ number should be translated from VIRQ to HWIRQ for TZIC.
> As a solution for this issue, move existing translation code
> from AVIC to common place.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Applied, thanks.
