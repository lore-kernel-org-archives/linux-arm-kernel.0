From: olof@lixom.net (Olof Johansson)
Date: Sat, 12 Jul 2014 09:59:48 -0700
Subject: [GIT PULL] Samsung cleanup for S5P SoCs for 3.17
In-Reply-To: <53BB2658.4050808@samsung.com>
References: <53BB2658.4050808@samsung.com>
Message-ID: <20140712165948.GA10012@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 08, 2014 at 07:59:36AM +0900, Kukjin Kim wrote:
> The following changes since commit a497c3ba1d97fc69c1e78e7b96435ba8c2cb42ee:
> 
>   Linux 3.16-rc2 (2014-06-21 19:02:54 -1000)
> 
> are available in the git repository at:
> 

> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> tags/s5p-cleanup
> 
> for you to fetch changes up to 58595ebd9306691441ccf88973b97d4f8eaa8279:
> 
>   ASoC: Samsung: remove s5pc100 related codes (2014-07-08 07:29:05 +0900)
> 
> ----------------------------------------------------------------
> Cleanup S5P SoCs for 3.17
> - removing s5p64x0 SoCs and s5pc100 SoC in mainline because
>   no more user and if it is required next time, it will be
>   supported with DT.
> 
> ----------------------------------------------------------------
> Kukjin Kim (13):
>       ARM: S5P64X0: no more support S5P6440 and S5P6450 SoCs
>       gpio: samsung: remove s5p64x0 related gpio codes
>       spi: s3c64xx: remove s5p64x0 related spi codes
>       ASoC: samsung: no more support for S5P6440 and S5P6450 SoCs
>       video: fbdev: s3c-fb: remove s5p64x0 related fimd codes
>       serial: samsung: no more support for S5P6440 and S5P6450 SoCs
>       ARM: S5PC100: no more support S5PC100 SoC
>       gpio: samsung: remov s5pc100 related gpio codes
>       spi: s3c64xx: remove s5pc100 related spi codes
>       serial: samsung: no more support for S5PC100 SoC
>       mtd: onenand: remove s5pc100 related onenand codes
>       video: fbdev: s3c-fb: remove s5pc100 related fimd and fb codes
>       ASoC: Samsung: remove s5pc100 related codes

I've merged these in. I noticed lack of acked-by from Mark Brown, so I pinged
him on IRC about it and the branch is currently at the top so it's easy to drop
in case he has objections (cc:d here too).


-Olof
