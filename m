From: olof@lixom.net (Olof Johansson)
Date: Thu, 4 Jan 2018 23:14:03 -0800
Subject: [GIT PULL 3/3] ARM: Keystone config update for 4.16
In-Reply-To: <1514426872-5769-3-git-send-email-santosh.shilimkar@oracle.com>
References: <1514426872-5769-1-git-send-email-santosh.shilimkar@oracle.com>
 <1514426872-5769-3-git-send-email-santosh.shilimkar@oracle.com>
Message-ID: <20180105071403.cqcbnezfqqp4dfyi@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 27, 2017 at 06:07:52PM -0800, Santosh Shilimkar wrote:
> Also had patch to sync up multi-v7 config but because of conflicts
> in next, have to drop it. Will send that post merge window separately
> 
> The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:
> 
>   Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone_config_for_4.16
> 
> for you to fetch changes up to 10f06c70f337494fc2fec623542186fec80fc395:
> 
>   ARM: configs: keystone_defconfig: Enable few peripheral drivers (2017-12-02 19:34:36 -0800)
> 
> ----------------------------------------------------------------
> ARM: Keystone configs for 4.16
> 
>   - Enable QSPI
>   - Enable LEDs
>   - Enable GPIO-decoder
> 
> ----------------------------------------------------------------
> Vignesh R (1):
>       ARM: configs: keystone_defconfig: Enable few peripheral drivers

Merged, thanks.


-Olof
