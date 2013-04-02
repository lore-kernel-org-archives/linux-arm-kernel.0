From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Tue, 2 Apr 2013 05:46:50 +0000
Subject: [PATCH v7 10/14] spi/spi-atmel: correct 16 bits transfers with DMA
In-Reply-To: <20130401135359.GB18636@opensource.wolfsonmicro.com>
References: <1363678866-3567-1-git-send-email-wenyou.yang@atmel.com>
 <1363679341-4087-1-git-send-email-wenyou.yang@atmel.com>
 <20130401135359.GB18636@opensource.wolfsonmicro.com>
Message-ID: <B256D81BAE5131468A838E5D7A24364150E8B304@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Mark,

> -----Original Message-----
> From: Mark Brown [mailto:broonie at opensource.wolfsonmicro.com]
> Sent: 2013?4?1? 21:54
> To: Yang, Wenyou
> Cc: linux-arm-kernel at lists.infradead.org; grant.likely at secretlab.ca;
> richard.genoud at gmail.com; plagnioj at jcrosoft.com; Ferre, Nicolas; Lin, JM;
> spi-devel-general at lists.sourceforge.net; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v7 10/14] spi/spi-atmel: correct 16 bits transfers with DMA
> 
> On Tue, Mar 19, 2013 at 03:49:01PM +0800, Wenyou Yang wrote:
> > From: Richard Genoud <richard.genoud@gmail.com>
> >
> > Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> > Cc: spi-devel-general at lists.sourceforge.net
> > Cc: linux-kernel at vger.kernel.org
> > [wenyou.yang at atmel.com: submit the patch]
> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> 
> Shouldn't this be squashed into the dmaengine patch?
OK, I will squash it into the dmaengine patch

Best Regards,
Wenyou Yang
