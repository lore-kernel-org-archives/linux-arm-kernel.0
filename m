From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Sat, 5 May 2018 15:16:51 +0800
Subject: [PATCH 0/2] Fix stm32-rng for default state and suspend
In-Reply-To: <20180423150426.22198-1-lionel.debieve@st.com>
References: <20180423150426.22198-1-lionel.debieve@st.com>
Message-ID: <20180505071651.qmroqj3ys3pve2x7@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2018 at 05:04:24PM +0200, Lionel Debieve wrote:
> This series are fixing the default build state for stm32-rng that
> activate the driver with arm multi_v7_defconfig.
> Second patch is fixing the power suspend/resume behavior which was
> not working.
> 
> Lionel Debieve (2):
>   hwrng: stm32 - define default state for rng driver
>   hwrng: stm32-rng: Fix pm_suspend issue
> 
>  drivers/char/hw_random/Kconfig     | 1 +
>  drivers/char/hw_random/stm32-rng.c | 9 +++++++--
>  2 files changed, 8 insertions(+), 2 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
