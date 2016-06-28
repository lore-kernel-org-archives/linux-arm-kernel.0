From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 28 Jun 2016 10:36:52 +0800
Subject: [PATCH] ARM: i.MX: Disable supervisor protect for i.MX51
In-Reply-To: <1466832375-32071-1-git-send-email-shc_work@mail.ru>
References: <1466832375-32071-1-git-send-email-shc_work@mail.ru>
Message-ID: <20160628023652.GE21328@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 25, 2016 at 08:26:15AM +0300, Alexander Shiyan wrote:
> Most peripherals on the i.MX51 have an Off-Platform Peripheral Access
> Control Register (OPACR) in which the access rights (together with the
> MPROT registers) can be declared.
> However, this does not seem to work for example for SSI1+SDMA, because the
> supervisor bit is not set for the SDMA unit.
> A similar problem was described in the patch for i.MX53 CPU
> (ARM: i.MX53: globally disable supervisor protect), and the same solution
> is applicable for i.MX51 CPU.
> Patch has tested on custom board based on Digi CCMX-51 module (i.MX51).
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Applied, thanks.
