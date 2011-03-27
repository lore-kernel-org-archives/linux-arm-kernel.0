From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sun, 27 Mar 2011 17:45:14 +0300
Subject: [PATCH RFC] ARM: PXA27x: CPUFREQ: Don't use fastbus mode
In-Reply-To: <4D8F0CD0.8010203@compulab.co.il>
References: <1301169103-23968-1-git-send-email-anarsoul@gmail.com>
	<201103271248.02774.anarsoul@gmail.com>
	<4D8F0CD0.8010203@compulab.co.il>
Message-ID: <201103271745.15216.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 27 March 2011 13:09:20 Igor Grinberg wrote:
> On 03/27/11 11:48, Vasily Khoruzhick wrote:
> > On Sunday 27 March 2011 12:09:21 Igor Grinberg wrote:
> >> Possibly, but Z2 is not the only one using PXA27x.
> >> And of course you lose performance, unless you don't care,
> >> because if it does not work at all, you don't care about performance,
> >> but again it is wrong to force all PXA27x based boards to this.
> > 
> > Ok, that's why I've sent this patch with RFC in subject - Z2 is the only
> > PXA270-based device I own :)
> > 
> >> cm-x270 and em-x270 work well with fast bus bit set with userspace
> >> governor and with the above frequencies.
> > 
> > What about ondemand and conservative governors?
> 
> I haven't tested those and I don't think I will have an opportunity in the
> near future, but is it really important also to test those? Are they
> different in any special way?

They switch freq rapidly, so they can be used as stability test for cpufreq 
implementation.

Regards
Vasily
