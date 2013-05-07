From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Tue, 7 May 2013 01:11:17 +0000
Subject: [PATCH v6 01/16] spi/spi-atmel: fix probing failure after
 xfer->speed_hz set
In-Reply-To: <20130506103105.GB13472@opensource.wolfsonmicro.com>
References: <1362626715-6549-1-git-send-email-wenyou.yang@atmel.com>
 <1362626815-6628-1-git-send-email-wenyou.yang@atmel.com>
 <CAGhQ9VwW18LXY5Jn0FUFCaAzKxP1W3QADG=JBp9JbgaAwo=F2Q@mail.gmail.com>
 <B256D81BAE5131468A838E5D7A24364154236AB5@penmbx02>
 <CACQ1gAhZO3stjrwf5SiZf7jOO8T5bAJZiz97M7+7vwFmk2e65g@mail.gmail.com>
 <5182414F.1000201@atmel.com>
 <20130506103105.GB13472@opensource.wolfsonmicro.com>
Message-ID: <B256D81BAE5131468A838E5D7A24364154238AF5@penmbx02>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Mark

> From: Mark Brown [mailto:broonie at kernel.org]
> Sent: 2013?5?6? 18:31
> To: Ferre, Nicolas
> Cc: grant.likely at secretlab.ca; Grant Likely; Richard Genoud; Yang, Wenyou;
> Joachim Eastwood; linux-arm-kernel at lists.infradead.org;
> plagnioj at jcrosoft.com; Lin, JM; spi-devel-general at lists.sourceforge.net;
> linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v6 01/16] spi/spi-atmel: fix probing failure after
> xfer->speed_hz set
> 
> On Thu, May 02, 2013 at 12:34:55PM +0200, Nicolas Ferre wrote:
> 
> > Can you tell us if this SPI patch will be merged upstream using one of
> > your paths?
> 
> I have no idea what patch this is but if it's not in my tree -next it's unlikely to be
> merged.
This is dropped patch, no need to be merged.

We tested Atmel spi in your tree-next , but it doesn't work, the reason is the Joachim Eastwood's patch is not included. 
https://patchwork.kernel.org/patch/2165301/
which Joachim said that Grant said he applied.

Thanks

Best Regards,
Wenyou Yang
