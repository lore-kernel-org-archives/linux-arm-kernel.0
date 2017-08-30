From: olof@lixom.net (Olof Johansson)
Date: Tue, 29 Aug 2017 22:37:59 -0700
Subject: [GIT PULL] Allwinner fixes for 4.13, take 3
In-Reply-To: <20170828092651.xwrz6toedrmht5nh@flea.lan>
References: <20170828092651.xwrz6toedrmht5nh@flea.lan>
Message-ID: <20170830053759.GK14499@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 28, 2017 at 11:26:51AM +0200, Maxime Ripard wrote:
> Hi,
> 
> Here is a bunch of patches essentially reverting the EMAC bindings
> additions. Indeed, it was discovered after the release of 4.13-rc1
> that we overlooked some issues while reviewing the driver, and we
> couldn't find a proper solution since then.
> 
> Since the binding is as such not stable yet, we can't allow it to
> reach a stable release.
> 
> Maxime
> 
> The following changes since commit d86e63e1f0b7868c55c8d4a54854b85e2bac690b:
> 
>   arm64: allwinner: h5: fix pinctrl IRQs (2017-08-14 14:18:21 +0800)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-fixes-for-4.13-3
> 
> for you to fetch changes up to fe45174b72aead678da581bab9e9a37c9b26a070:
> 
>   arm: dts: sunxi: Revert EMAC changes (2017-08-28 11:11:24 +0200)

Merged but unfortunately this introduces quite annoying conflicts with already
queued up DT contents. Fixed up those as well.


-Olof
