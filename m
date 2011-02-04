From: tony@atomide.com (Tony Lindgren)
Date: Thu, 3 Feb 2011 17:47:39 -0800
Subject: [PATCH v4 1/4] drivers: hwspinlock: add framework
In-Reply-To: <20110202121147.GA24993@n2100.arm.linux.org.uk>
References: <1296470024-26854-1-git-send-email-ohad@wizery.com>
	<1296470024-26854-2-git-send-email-ohad@wizery.com>
	<20110131153831.dca62146.akpm@linux-foundation.org>
	<AANLkTik-fgCF_W0-DBE6UVTpjqF6Jf=u7bQYkcweEegQ@mail.gmail.com>
	<20110131223859.27169db0.akpm@linux-foundation.org>
	<AANLkTinJLAT0B61Eu1Chn9k9rmbHXa1ZNcedo_m8TZp3@mail.gmail.com>
	<20110131234028.8744b5fd.akpm@linux-foundation.org>
	<AANLkTi=zOO_vDQ4+LWQs38xjo+VaRG0jfgo6ifvh=L-M@mail.gmail.com>
	<20110202121147.GA24993@n2100.arm.linux.org.uk>
Message-ID: <20110204014738.GP3322@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110202 04:10]:
> On Tue, Feb 01, 2011 at 10:12:38AM +0200, Ohad Ben-Cohen wrote:
> > On Tue, Feb 1, 2011 at 9:40 AM, Andrew Morton <akpm@linux-foundation.org> wrote:
> > > On Tue, 1 Feb 2011 09:36:22 +0200 Ohad Ben-Cohen <ohad@wizery.com> wrote:
> > >
> > >> On Tue, Feb 1, 2011 at 8:38 AM, Andrew Morton <akpm@linux-foundation.org> wrote:
> > >> >> I'll do a quick respin of the patches with that and the
> > >> >> hwspinlock_internal.h comment above.
> > >> >
> > >> > OK..
> > >> >
> > >> > The patch series looks OK to me.
> > >>
> > >> Can I add your Acked-by on the non-omap parts when I respin the series ?
> > >
> > > spose so. ?I don't normally do acked-by's. ?I think it's my way of
> > > avoiding getting blamed when it all blows up.
> > 
> > I don't want to be breaking old habits then :)
> > 
> > >> > Maybe Tony or Russell or Greg can grab them
> > >> > if they like the look of it all?
> > 
> > Let's just wait a bit for Tony's or Russell's or Greg's answer.
> 
> As it touches OMAP code, it makes sense to merge it through Tony's tree
> as that should reduce the number of possible conflicts.

OK I'll take them then.

Regards,

Tony
