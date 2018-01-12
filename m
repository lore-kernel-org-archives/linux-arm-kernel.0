From: olof@lixom.net (Olof Johansson)
Date: Thu, 11 Jan 2018 18:05:47 -0800
Subject: [GIT PULL] tee dynamic shm fixes for v4.16
In-Reply-To: <20180111124456.2fziqy4sdxq5wdlz@jax>
References: <20180111124456.2fziqy4sdxq5wdlz@jax>
Message-ID: <20180112020547.7vkatughmu6af6d7@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 11, 2018 at 01:44:56PM +0100, Jens Wiklander wrote:
> Hello arm-soc maintainers,
> 
> Please pull these fixes for the previous tee-drv-dynamic-shm-for-v4.16
> pull request that is currently kept in the drivers/tee-2 branch in the
> arm-soc git.
> 
> This pull request addresses the question about registering memory that
> isn't regular memory. I posted those patches some time ago with no feedback
> so far.
> 
> There's also three small fixes to the dynamic shm patches that I've
> picked up from the mailing lists.
> 
> Thanks,
> Jens
> 
> 
> The following changes since commit ef8e08d24ca84846ce639b835ebd2f15a943f42b:
> 
>   tee: shm: inline tee_shm_get_id() (2017-12-15 13:36:21 +0100)
> 
> are available in the git repository at:
> 
>   https://git.linaro.org/people/jens.wiklander/linux-tee.git tee-drv-dynamic-shm+fixes-for-v4.16
> 
> for you to fetch changes up to 2490cdf6435b1d3cac0dbf710cd752487c67c296:
> 
>   tee: shm: Potential NULL dereference calling tee_shm_register() (2018-01-09 14:34:00 +0100)
> 
> ----------------------------------------------------------------
> This pull request updates the previous tee-drv-dynamic-shm-for-v4.16 pull
> request with five new patches fixing review comments and errors.
> 
> Apart from three small fixes there's two larger patches that in the end
> checks that memory to be registered really is normal cached memory.

Merged into next/drivers. I noticed git.linaro.org is really slow though,
maybe you should look into getting a kernel.org account instead? It took about
a minute for the pull request to complete.


-Olof
