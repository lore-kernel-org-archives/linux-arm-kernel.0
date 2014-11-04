From: olof@lixom.net (Olof Johansson)
Date: Tue, 4 Nov 2014 14:40:47 -0800
Subject: [GIT PULL 2/2] cpufreq-dt platform device
In-Reply-To: <5165858.6mpQCFJLYm@diego>
References: <8735180.PYWUSJW9sD@diego>
 <5165858.6mpQCFJLYm@diego>
Message-ID: <20141104224047.GH5908@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 29, 2014 at 05:15:37PM +0100, Heiko St?bner wrote:
> Hi Arnd, Olof,
> 
> this pull contains the cpufreq-dt device creation needed for cpu frequency
> scaling on Rockchip platforms.
> 
> While this is only a single patch, there are more soc-changes in the pipeline
> (rk3288-smp and suspend) that'll hopefully marture in time for 3.19, so this
> probably should get a separate branch in arm-soc and not be merge into the
> dt-branch.
> 
> 
> Thanks
> Heiko
> 
> 
> The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:
> 
>   Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v3.19-rockchip-soc1
> 
> for you to fetch changes up to d3bafa3c09592448358887cfc722f72932134950:
> 
>   ARM: rockchip: add a cpufreq-dt device (2014-10-20 11:57:56 +0200)

Ack, I merged the previous version of this that was based on 3.17-rc
last night.  Still, should work just fine to use that as a base for
future branches if needed.


-Olof
