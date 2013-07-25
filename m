From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Fri, 26 Jul 2013 00:41:09 +0200
Subject: [RESEND] cpuidle for ARM pull request
In-Reply-To: <1766778.ZYeDKBOsjV@vostro.rjw.lan>
References: <51E536C5.1020609@linaro.org> <51F1A187.5060408@linaro.org>
 <1766778.ZYeDKBOsjV@vostro.rjw.lan>
Message-ID: <2075555.RCmWLFAfjq@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, July 26, 2013 12:29:08 AM Rafael J. Wysocki wrote:
> On Friday, July 26, 2013 12:07:03 AM Daniel Lezcano wrote:
> > On 07/16/2013 02:04 PM, Daniel Lezcano wrote:
> > > 
> > > Hi,
> > > 
> > > The first PR was against the linux-pm-next tree including the patch:
> > > 
> > > "cpuidle: Add Kconfig.arm and move calxeda, kirkwood and zynq"
> > > 
> > > This patch has been dropped in the meantime.
> > > 
> > > Here is a new PR where my tree has been rebased against linux-pm-next
> > > and adding the patch mentioned above.
> > > 
> > > As stated by Rafael, I will handle the ARM specific patches from now.
> > > 
> > > The following changes since commit 48f99d5a97d32d70c0738d6e314d9f4dbefd89bf:
> > > 
> > >   Merge branch 'pm-cpuidle-next' into linux-next (2013-07-16 02:41:06 +0200)
> > > 
> > > are available in the git repository at:
> > > 
> > > 
> > >   git://git.linaro.org/people/dlezcano/linux.git cpuidle/arm-next
> > > 
> > > for you to fetch changes up to 2b7e79f4a75e803184f483985a25cc751a990f06:
> > > 
> > >   ARM: ux500: cpuidle: Move ux500 cpuidle driver to drivers/cpuidle
> > > (2013-07-16 13:57:24 +0200)
> > 
> > ping ?
> 
> Sorry, something distracted me.  I'll pull it later today unless there are any
> problems (in which case I'll let you know).

Well, there are some.

It is based on my linux-next branch, but please rebase it on top of 3.11-rc2.

Generally, please send me pull requests based on -rc kernels only (or major
releases).

Thanks,
Rafael
