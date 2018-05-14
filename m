From: olof@lixom.net (Olof Johansson)
Date: Mon, 14 May 2018 01:02:24 -0700
Subject: [GIT PULL] tee driver fixes for v4.17
In-Reply-To: <20180507124731.GA21011@jax.urgonet>
References: <20180507124731.GA21011@jax.urgonet>
Message-ID: <20180514080224.zy7s4f5d2uiibwce@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 07, 2018 at 02:47:31PM +0200, Jens Wiklander wrote:
> Hello arm-soc maintainers,
> 
> Please pull these tee driver fixes. Of particular interest is a fix for a
> use-after-free issue. There's also a fix making sure that memory references
> are kept within the used shm object.
> 
> Thanks,
> Jens
> 
> The following changes since commit 75bc37fefc4471e718ba8e651aa74673d4e0a9eb:
> 
>   Linux 4.17-rc4 (2018-05-06 16:57:38 -1000)
> 
> are available in the Git repository at:
> 
>   git://git.linaro.org/people/jens.wiklander/linux-tee.git/ tags/tee-drv-fixes-for-4.17
> 
> for you to fetch changes up to ab9d3db5b320a052452b9cd035599ee3c84bbee9:
> 
>   tee: check shm references are consistent in offset/size (2018-05-07 11:51:03 +0200)
> 
> ----------------------------------------------------------------
> Small fixes for tee subsystem
> 
> * Fixes for use-after-free via temporarily dropped reference
> * Checks that passed shm references are consistent in offset/size
>   with regards to the shm object

Merged, thanks!


-Olof
