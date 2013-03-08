From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Fri, 8 Mar 2013 09:43:49 +0000
Subject: [PATCH v6 01/16] spi/spi-atmel: fix probing failure after
 xfer->speed_hz set
In-Reply-To: <51388575.4050506@cogentembedded.com>
References: <1362626715-6549-1-git-send-email-wenyou.yang@atmel.com>
 <1362626815-6628-1-git-send-email-wenyou.yang@atmel.com>
 <51388575.4050506@cogentembedded.com>
Message-ID: <B256D81BAE5131468A838E5D7A24364149720050@penmbx02>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Serqei,

> -----Original Message-----
> From: Sergei Shtylyov [mailto:sergei.shtylyov at cogentembedded.com]
> Sent: 2013?3?7? 20:18
> To: Yang, Wenyou
> Cc: linux-arm-kernel at lists.infradead.org; richard.genoud at gmail.com; Lin, JM;
> Ferre, Nicolas; linux-kernel at vger.kernel.org; grant.likely at secretlab.ca;
> spi-devel-general at lists.sourceforge.net; plagnioj at jcrosoft.com
> Subject: Re: [PATCH v6 01/16] spi/spi-atmel: fix probing failure after
> xfer->speed_hz set
> 
> Hello.
> 
> On 07-03-2013 7:26, Wenyou Yang wrote:
> 
> > commit: 059b8ffeee5b427949872bb6ed5db5ae0788054e
> 
>     Please also specify the summary line of that commit in parens (or however
> you like).
Thanks for your suggestion.

> 
> > cause the atmel spi probing failure.
> 
> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> > Cc: spi-devel-general at lists.sourceforge.net
> > Cc: linux-kernel at vger.kernel.org
> 
> WBR, Sergei

Best Regards,
Wenyou Yang
