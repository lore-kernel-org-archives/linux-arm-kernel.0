From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Jul 2011 23:06:15 +0200
Subject: [GIT PULL] MSM fix
In-Reply-To: <20110720203703.GA4495@huya.qualcomm.com>
References: <20110720203703.GA4495@huya.qualcomm.com>
Message-ID: <1989166.1WcWHOXyl7@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 July 2011 13:37:03 David Brown wrote:
> I seem to have missed this fix when it was sent out in April.
> 
> The following changes since commit 620917de59eeb934b9f8cf35cc2d95c1ac8ed0fc:
> 
>   Linux 3.0-rc7 (2011-07-11 16:51:52 -0700)
> 
> are available in the git repository at:
>   git://codeaurora.org/quic/kernel/davidb/linux-msm.git msm-fix
> 
> Jeff Ohlstein (1):
>       msm: platsmp: actually read core count in get_core_count
> 

Hmm, this one seems like it really applies to older kernels as well, so
we can just as well add a cc:stable at kernel.org tag and put it into the
arm-soc/next/fixes branch, right?

Linus has just pulled the 'last arm-soc fixes for 3.0' branch, and I don't
really want to follow up with 'last fix, this time for real' pull request
unless it's for a serious regression.

On a related topic, what's the deal with the msm-core and msm-move-gpio
branches in the same tree? I have the impression that they should be
in arm-soc.git, but I never received a pull request.

The msm-move-gpio branch looks like it wasn't merged into the gpio
tree either, which would be the other logical place, and the msm-core
branch is currently in linux-next but hasn't been updated since April.

	Arnd
