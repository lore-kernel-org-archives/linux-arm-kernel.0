From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 11 Oct 2013 22:30:18 +0000 (UTC)
Subject: [GIT PULL] ARM: OMAP2+: hwmod changes for v3.13
In-Reply-To: <20131011222634.GB29913@atomide.com>
References: <alpine.DEB.2.02.1310111659500.27397@utopia.booyaka.com>
 <20131011222634.GB29913@atomide.com>
Message-ID: <alpine.DEB.2.02.1310112229180.27397@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Oct 2013, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [131011 10:08]:
>
> > Basic test logs are available at:
> > 
> > http://www.pwsan.com/omap/testlogs/prcm_fixes_v3.13/20131009094936/
> > 
> > The summary reports that the 4460varsomom boots are failing, but this looks
> > incorrect - it's probably a bug in the validation scripts here.
> 
> OK I'll do a test on my panda es before sending out the branches
> and will apply that one hwmod patch Benoit had queued on top
> of this. So pulling into omap-for-v3.13/hwmod.

Thanks.  It boots fine on 4460varsomom, if you look at the boot log:

http://www.pwsan.com/omap/testlogs/prcm_fixes_v3.13/20131009094936/boot/4460varsomom/4460varsomom_log.txt

Otherwise I wouldn't have sent the pull request.


- Paul
