From: olof@lixom.net (Olof Johansson)
Date: Sun, 1 Jun 2014 20:28:34 -0700
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
In-Reply-To: <20140602104957.21878870@canb.auug.org.au>
References: <20140602104957.21878870@canb.auug.org.au>
Message-ID: <CAOesGMhDqYKSvxTK9pDnvWbmEUK_WUFKxGLJemZO6uFxtROcLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 1, 2014 at 5:49 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> Today's linux-next merge of the arm-soc tree got a conflict in
> arch/arm/mach-exynos/exynos.c between commits dfbdd3d55403 ("ARM: l2c:
> exynos: remove cache size override"), 25a9ef63cd2b ("ARM: l2c: exynos:
> convert to common l2c310 early resume functionality") and 15b0bc4041ba
> ("ARM: l2c: exynos: convert to generic l2c OF initialisation (and
> thereby fix it)") from the arm tree and commit b5b9324a6296 ("ARM:
> exynos: don't run exynos4 l2x0 setup on other platforms") from the
> arm-soc tree.
>
> I fixed it up (the former removes the code updated by the latter) and
> can carry the fix as necessary (no action is required).

Looks good. Thanks.


-Olof
