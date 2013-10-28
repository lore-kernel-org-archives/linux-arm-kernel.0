From: olof@lixom.net (Olof Johansson)
Date: Sun, 27 Oct 2013 21:38:38 -0700
Subject: [GIT PULL 4/6] Samsung s3c64xx-dt for v3.13
In-Reply-To: <526455F0.201@samsung.com>
References: <526455F0.201@samsung.com>
Message-ID: <20131028043838.GJ22890@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 21, 2013 at 07:15:12AM +0900, Kukjin Kim wrote:
> The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:
> 
>   Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)
> 
> are available in the git repository at:
> 

> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> tags/s3c64xx-dt
> 
> for you to fetch changes up to 2ec35a4252eae3d5277af041bd1b5ae4f6183cad:
> 
>   ARM: dts: Add dts file for S3C6410-based SMDK6410 board
> (2013-09-17 06:48:29 +0900)
> 
> ----------------------------------------------------------------
> Device tree for S3C64XX
> - based on common-clk-s3c64xx branch
> - add s3c64xx dt board file for using dt
> - add dts file for s3c6410-smdk6410 board
> - add dts file for s3c6410-mini6410 board

Same here, we already have it.

If you try to merge the different pull requests into our for-next branch before
you send them out you would see this. It would also give you an indication
whether we would see merge conflicts at our end so you can give us a heads up
about it.


-Olof
