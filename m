From: olof@lixom.net (Olof Johansson)
Date: Sun, 9 Dec 2012 22:49:59 -0800
Subject: linux-next: manual merge of the arm-soc tree with the sound-asoc
 tree
In-Reply-To: <20121210174057.9862b43ff7350ba20c048df3@canb.auug.org.au>
References: <20121210174057.9862b43ff7350ba20c048df3@canb.auug.org.au>
Message-ID: <CAOesGMixeGKmie_dioz24O1MD+2KJEn2z-gvHtZojgjCnsdJXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 9, 2012 at 10:40 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> Today's linux-next merge of the arm-soc tree got a conflict in
> arch/arm/plat-samsung/include/plat/devs.h between commit a08485d8fdf6
> ("ASoC: Samsung: Do not register samsung audio dma device as pdev") from
> the sound-asoc tree and commit 0a9d5ac307ae ("ARM: EXYNOS: removing
> exynos-drm device registration from non-dt platforms") from the arm-soc
> tree.
>
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).

Looks good, thanks.


-Olof
