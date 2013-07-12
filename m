From: olof@lixom.net (Olof Johansson)
Date: Fri, 12 Jul 2013 11:04:20 -0700
Subject: [PATCH linux-next] arm: multi_v7_defconfig: add fsl lpuart
 serial console
In-Reply-To: <1373392491-32056-1-git-send-email-vincent.stehle@freescale.com>
References: <1373392491-32056-1-git-send-email-vincent.stehle@freescale.com>
Message-ID: <20130712180420.GA28285@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 09, 2013 at 07:54:51PM +0200, Vincent Stehl? wrote:
> Add Freescale LPUART serial console support. This gives us the boot messages on
> UART on e.g. the Vybrid VF610 Tower board.
> 
> Signed-off-by: Vincent Stehl? <vincent.stehle@freescale.com>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Russell King <linux@arm.linux.org.uk>
> ---
> 
> 
> Hi,
> 
> Would you please consider adding LPUART for ARM multi_v7_defconfig, please?
> 
> (This patch is built on top of the following patches:
> http://comments.gmane.org/gmane.linux.kernel/1519712)
> 
> Best regards,

Thanks, applied to fixes. Note that I squashed together the three patches to
one though.


-Olof
