From: sangsu4u.park@samsung.com (Sangsu Park)
Date: Thu, 06 Sep 2012 17:57:45 +0900
Subject: [PATCH] ASoC: SAMSUNG: Add SND_SOC_DAIFMT_CONT option for
 snd_soc_set_fmt()
In-Reply-To: <20120906002145.GU10580@opensource.wolfsonmicro.com>
References: <003101cd8367$3476e650$9d64b2f0$@samsung.com>
 <20120827204550.GA4400@opensource.wolfsonmicro.com>
 <001d01cd85d6$59298040$0b7c80c0$@samsung.com>
 <20120830174317.GG4356@opensource.wolfsonmicro.com>
 <001001cd8979$3b260d10$b1722730$@samsung.com>
 <20120906002145.GU10580@opensource.wolfsonmicro.com>
Message-ID: <006601cd8c0d$aeca9d30$0c5fd790$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thurs, Sep 06, 2012 at 9:22 AM +0900, Mark Brown wrote:
> On Mon, Sep 03, 2012 at 11:10:03AM +0900, Sangsu Park wrote:
> > On Sun, Aug 31, 2012 at 2:43 AM +0900, Mark Brown wrote:
> > > On Wed, Aug 29, 2012 at 08:06:32PM +0900, Sangsu Park wrote:
> 
> > > Please check your mailer configuration, it looks like it's reformatting
> > > all the text with much longer line widths.
> 
> > I've changed line width configuration. Is it ok now?
> 
> Looks like it, thanks.
> 
> > Do you think that changing pcm driver is right approach?
> > Then I'll fix pcm driver. (I think that pcm driver has some strange code.)
> 
> Well, we could do both.  It'd certainly be more natural to make it have
> a default given that this isn't something that normally needs to be
> configured.
> 
Then, I'll fix pcm driver to use default given
and resend that patch.

Thanks.
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
