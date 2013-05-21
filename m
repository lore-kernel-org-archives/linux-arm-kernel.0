From: sameo@linux.intel.com (Samuel Ortiz)
Date: Tue, 21 May 2013 10:56:50 +0200
Subject: [GIT PULL v2] MFD: Fixes due for the v3.10 -rc:s
In-Reply-To: <20130517075140.GA25077@balto.lan>
References: <20130514091956.GG3297@gmail.com> <20130515090449.GA3494@gmail.com>
 <20130516224337.GZ22822@zurbaran>
 <20130517075140.GA25077@balto.lan>
Message-ID: <20130521085650.GB4589@zurbaran>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Fri, May 17, 2013 at 09:51:40AM +0200, Fabio Baltieri wrote:
> Hello Samuel,
> 
> On Fri, May 17, 2013 at 12:43:37AM +0200, Samuel Ortiz wrote:
> > > Fabio Baltieri (5):
> > >       mfd: abx500-core: Fix sparse warning
> > >       mfd: ab8500-sysctrl: Fix sparse warning
> > >       mfd: ab8500-sysctrl: Set sysctrl_dev during probe
> > >       mfd: ab8500-sysctrl: Let sysctrl driver work without pdata
> > Unless I'm missing something here, this one is not really rcN material, so
> > I'd appreciate if you could queue it to your for-mfd branch instead.
> 
> The last two:
> 
>   mfd: ab8500-sysctrl: Set sysctrl_dev during probe
This one is already in mfd-fixes, the commit log was clear enough.


>   mfd: ab8500-sysctrl: Let sysctrl driver work without pdata
This one is not, as the commit log is not showing it actually fixes something
but only makes the code cleaner. If it really fixes something, could you
please provide me with a commit log that describes what exactly it fixes ?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
