From: tony@atomide.com (Tony Lindgren)
Date: Fri, 1 Aug 2014 01:02:46 -0700
Subject: [PATCH 3/3] arm: dts: Add gta04a5 model
In-Reply-To: <CABxcv=n7g8c2ePGKgu_0Y35iearcRoAj9ZH5jDWY9nE+1uUKnA@mail.gmail.com>
References: <1406577213-9642-1-git-send-email-marek@goldelico.com>
 <1406577213-9642-4-git-send-email-marek@goldelico.com>
 <CAOf5uwk=ctww=pP4Ae+1C6i-oOtiYTv2NJbj1GpuPwVSKXB4Hw@mail.gmail.com>
 <CAAfyv35jvhzvjCKMwrpa=RQ1JkfcmthCsGDzwLW9Y6bq3Ww_fg@mail.gmail.com>
 <CAOf5uw=Fm9FXEH5ESqDC8pGjMbn5VQ1+MyPJVXSqGh_9+JRLHw@mail.gmail.com>
 <1FA8171E-1B7A-4684-887E-11593BB9C29E@goldelico.com>
 <20140729124120.GS29045@atomide.com>
 <589F7CA3-F245-4299-8E39-36A7FA9F3CBD@goldelico.com>
 <CABxcv=n7g8c2ePGKgu_0Y35iearcRoAj9ZH5jDWY9nE+1uUKnA@mail.gmail.com>
Message-ID: <20140801080246.GG29045@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Javier Martinez Canillas <javier@dowhile0.org> [140729 07:14]:
> Hello,
> 
> On Tue, Jul 29, 2014 at 3:03 PM, Dr. H. Nikolaus Schaller
> <hns@goldelico.com> wrote:
> > Hi,
> >> So what's the conclusion? Are changes needed to this patch
> >> series or not?
> >
> > I advocate that no changes are needed.
> >
> 
> I agree with Dr. H. Nikolaus on this regard. A DeviceTree should be a
> description of the hardware and if two hardware platforms differs,
> then we need two different DTS.
> 
> Lately I'm seeing some attempts to abuse u-boot's fdt command, u-boot
> should only modify the strictly necessary like the /chosen branch.
> Allowing u-boot to mangle the FDT before passing to the kernel just to
> avoid some DT duplication doesn't sound like a good idea IMHO.

OK no more comments, so applied all into omap-for-v3.17/dt.
As there's a good chance the merge window will open on Monday,
no guarantees the gta04 related changes will make it. But I'll
send a pull request a bit later on today for them anyways.

Regards,

Tony
