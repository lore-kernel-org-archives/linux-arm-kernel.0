From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 2 Nov 2012 21:42:24 +0800
Subject: [PATCH 09/10] ARM: SMP: add function arch_send_wakeup_ipi_mask()
In-Reply-To: <20121031034331.GB8100@S2100-06.ap.freescale.net>
References: <1351005779-30347-1-git-send-email-shawn.guo@linaro.org>
 <1351005779-30347-10-git-send-email-shawn.guo@linaro.org>
 <20121031034331.GB8100@S2100-06.ap.freescale.net>
Message-ID: <20121102134223.GB11641@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 31, 2012 at 11:43:34AM +0800, Shawn Guo wrote:
> On Tue, Oct 23, 2012 at 11:22:58PM +0800, Shawn Guo wrote:
> > Add function arch_send_wakeup_ipi_mask(), so that platform code can
> > use it as an easy way to wake up cores that are in WFI.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Russell King <linux@arm.linux.org.uk>
> 
> Hi Russell,
> 
> Can I ask for your ack to have the patch go via arm-soc being part
> of the series?
> 
Ping

Shawn
