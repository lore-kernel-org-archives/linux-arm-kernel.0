From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Wed, 5 Nov 2014 10:05:10 +0000
Subject: [PATCH v3 0/3] i2c/at91: add support PM functions
In-Reply-To: <20141029082429.GG9284@ldesroches-Latitude-E6320>
References: <1414133417-11530-1-git-send-email-wenyou.yang@atmel.com>
 <20141029082429.GG9284@ldesroches-Latitude-E6320>
Message-ID: <B256D81BAE5131468A838E5D7A243641BF5A90B2@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

Could you give me some advice?  Thank you in advance.

> -----Original Message-----
> From: Ludovic Desroches [mailto:ludovic.desroches at atmel.com]
> Sent: Wednesday, October 29, 2014 4:24 PM
> To: Yang, Wenyou
> Cc: wsa at the-dreams.de; Desroches, Ludovic; linux-i2c at vger.kernel.org; linux-
> kernel at vger.kernel.org; Ferre, Nicolas; khilman at kernel.org; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH v3 0/3] i2c/at91: add support PM functions
> 
> For the whole serie
> 
> Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> On Fri, Oct 24, 2014 at 02:50:14PM +0800, Wenyou Yang wrote:
> > Hi Wolfram,
> >
> > The patches is to add the PM functions support for the at91 i2c controller.
> >
> > It is based on the i2c/for-next branch of
> > git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git.
> >
> > Best Regards,
> > Wenyou Yang
> >
> > ------
> > Change log:
> > v2.0
> >
> > According to the advice from Kevin Hilman, 1./ Wrap the runtime
> > suspend/resume functions in CONFIG_PM instead of CONFIG_PM_RUNTIME.
> > 2./ Call the runtime suspend/resume functions directly in the system
> suspend/resume.
> >
> > v3.0
> >    Covert the system suspend/resume to suspend_noirq/resume_noirq.
> >
> > Wenyou Yang (3):
> >   i2c/at91: add support for runtime PM
> >   i2c/at91: add support for system PM
> >   i2c/at91: adopt pinctrl support
> >
> >  drivers/i2c/busses/i2c-at91.c |   71
> +++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 65 insertions(+), 6 deletions(-)
> >
> > --
> > 1.7.9.5
> >

Best Regards,
Wenyou Yang
