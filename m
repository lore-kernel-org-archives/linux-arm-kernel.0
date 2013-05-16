From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 17 May 2013 00:43:37 +0200
Subject: [GIT PULL v2] MFD: Fixes due for the v3.10 -rc:s
In-Reply-To: <20130515090449.GA3494@gmail.com>
References: <20130514091956.GG3297@gmail.com> <20130515090449.GA3494@gmail.com>
Message-ID: <20130516224337.GZ22822@zurbaran>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Wed, May 15, 2013 at 10:04:49AM +0100, Lee Jones wrote:
> Hi Sam,
> 
> Since v1 of my MFD -fixes pull-request, I have applied a few more
> patches which really should be entered into the -rc:s. As it appears
> that you have not yet pulled v1, I figured sending a v2 in its place
> would be appropriate, so here it is.
This almost looks good, I just have one comment:

> Fabio Baltieri (5):
>       mfd: abx500-core: Fix sparse warning
>       mfd: ab8500-sysctrl: Fix sparse warning
>       mfd: ab8500-sysctrl: Set sysctrl_dev during probe
>       mfd: ab8500-sysctrl: Let sysctrl driver work without pdata
Unless I'm missing something here, this one is not really rcN material, so
I'd appreciate if you could queue it to your for-mfd branch instead.

The rest is pulled and applied, thanks again.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
