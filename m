From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Tue, 2 Apr 2013 05:45:48 +0000
Subject: [PATCH v7 08/14] spi/spi-atmel: fix spi-atmel driver to adapt
 to slave_config changes
In-Reply-To: <20130401135104.GZ18636@opensource.wolfsonmicro.com>
References: <1363678866-3567-1-git-send-email-wenyou.yang@atmel.com>
 <1363679236-3973-1-git-send-email-wenyou.yang@atmel.com>
 <20130401135104.GZ18636@opensource.wolfsonmicro.com>
Message-ID: <B256D81BAE5131468A838E5D7A24364150E8A2ED@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Mark,

> -----Original Message-----
> From: Mark Brown [mailto:broonie at opensource.wolfsonmicro.com]
> Sent: 2013?4?1? 21:51
> To: Yang, Wenyou
> Cc: linux-arm-kernel at lists.infradead.org; grant.likely at secretlab.ca;
> richard.genoud at gmail.com; plagnioj at jcrosoft.com; Ferre, Nicolas; Lin, JM;
> spi-devel-general at lists.sourceforge.net; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v7 08/14] spi/spi-atmel: fix spi-atmel driver to adapt to
> slave_config changes
> 
> On Tue, Mar 19, 2013 at 03:47:16PM +0800, Wenyou Yang wrote:
> > From: Richard Genoud <richard.genoud@gmail.com>
> >
> > This is the following of the patch
> > e2b35f3dbfc080f15b72834d08f04f0269dbe9be
> 
> What is this patch actually doing, shouldn't it be part of the previous commit?
> The changelog really ought to have a plain text version of the commit
> description too.
You are right, it isn't the part of the previous commit.
I will squash it into the dmaengine patch.

Best Regards,
Wenyou Yang
