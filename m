From: olof@lixom.net (Olof Johansson)
Date: Wed, 24 Sep 2014 11:21:30 -0700
Subject: [GIT PULL 1/3] ARM: imx: cleanup for 3.18
In-Reply-To: <20140916044540.GA25583@dragon>
References: <20140916044540.GA25583@dragon>
Message-ID: <20140924182130.GH19284@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 16, 2014 at 12:45:41PM +0800, Shawn Guo wrote:
> The following changes since commit 69e273c0b0a3c337a521d083374c918dc52c666f:
> 
>   Linux 3.17-rc3 (2014-08-31 18:23:04 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-cleanup-3.18
> 
> for you to fetch changes up to 64d14a31d5410ea34641c41795e0ba222bda740c:
> 
>   ARM: imx: Remove mach-mxt_td60 board file (2014-09-10 11:17:44 +0800)
> 
> ----------------------------------------------------------------
> The i.MX cleanup for 3.18:
>  - Reomve a few i.MX27 and i.MX1 board files
>  - Remove imx_scu_standby_enable() since core code handles scu
>    standby now
>  - Remove unnecessary iomux declaration
>  - Remove useless sound card property from vf610-twr dts

Merged, thanks.


-Olof
