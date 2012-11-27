From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Tue, 27 Nov 2012 12:38:15 +0100
Subject: [PATCH] cpufreq: SPEAr: Add CPUFreq driver
In-Reply-To: <CAKohpomSAogQVeBQ8HaWwwoTVCsMha5d_1Wid6N3t5SnVZTc=w@mail.gmail.com>
References: <7ec0e3f4b81b70f3def4257e6b9781efd4c7a3d2.1353785862.git.viresh.kumar@linaro.org>
 <20121127040135.GB27305@S2100-06.ap.freescale.net>
 <CAKohpomSAogQVeBQ8HaWwwoTVCsMha5d_1Wid6N3t5SnVZTc=w@mail.gmail.com>
Message-ID: <1728458.5AqJNfNVgK@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, November 27, 2012 09:28:01 AM Viresh Kumar wrote:
> Hi Shawn,
> 
> Thanks for feedback.
> 
> On 27 November 2012 09:31, Shawn Guo <shawn.guo@linaro.org> wrote:
> > On Sun, Nov 25, 2012 at 01:09:28AM +0530, Viresh Kumar wrote:
> >> +cpufreq {
> >> +     compatible = "st,cpufreq-spear";
> >
> > I do not think we need a "cpufreq" node, as we already have node for
> > cpu to contain these.
> 
> Hmm.. Yes, can be done.

OK, so changes are going to be made to the driver, right?

I'll drop it then and please resubmit when ready (and tested) after the changes.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
