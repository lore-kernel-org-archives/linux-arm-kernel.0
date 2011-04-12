From: marek.vasut.n900@gmail.com (Marek Vasut)
Date: Tue, 12 Apr 2011 07:22:26 +0200
Subject: [PATCH RFC] ARM: PXA27x: CPUFREQ: Don't use fastbus mode
In-Reply-To: <201104112311.01002.anarsoul@gmail.com>
References: <1301169103-23968-1-git-send-email-anarsoul@gmail.com>
	<4D8EFEC1.7010803@compulab.co.il> <20110411134642.GA1519@ucw.cz>
	<201104112311.01002.anarsoul@gmail.com>
Message-ID: <1302585746.6862.2.camel@konomi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Monday 11 April 2011 16:46:43 Pavel Machek wrote:
> > Hi!
> > 
> > Well, some other pxa27x machcines?  (spitz) are crashing randomly for
> > _years_ now... so maybe the problem is more widespread?
> > 
> > How easy is to trigger the problem? Do you have script?
> > 
> > Is it possible that this bug triggers with governor==performance.
> 
> It's hard to trigger it with performance governor (because it's quite
> stable?  @416mhz even with fastbus), so I suggest trying ondemand or
> conservative?  governors.

Iirc ondemand crashes it easily, yes.
