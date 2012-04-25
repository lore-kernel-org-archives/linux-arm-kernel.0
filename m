From: broonie@sirena.org.uk (Mark Brown)
Date: Wed, 25 Apr 2012 11:46:00 +0100
Subject: Tag on pinctrl
In-Reply-To: <4F96D84E.7080204@wwwdotorg.org>
References: <CACRpkdYqZrNFxj4kyMqYZk5PAcjF6-TroJ+Xq+3EVBLvo5Zg-Q@mail.gmail.com>
 <4F96D84E.7080204@wwwdotorg.org>
Message-ID: <20120425104559.GA16752@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2012 at 10:43:58AM -0600, Stephen Warren wrote:

> Yes, I have pulled that tag into the Tegra tree as
> for-3.5/gpio-pinmux-dependency, and have a Tegra-specific
> for-3.5/gpio-pinmux branch that depends on it. Two other Tegra branches
> in turn (for-3.5/tegra30-audio, for-3.5/usb-ulpi) depend on
> for-3.5/gpio-pinmux.

> Linus, I think this will get into the ARM SoC tree simply by my saying
> in my for-3.5/gpio-pinmux pull request that the branch depends on your
> tag; I don't /think/ you need to explicitly send a pull request there,
> right?

If the gpio-pinmux branch is based on Linus' branch (which it really
should be if it's a dependency...) then git will do the right thing
here.  If it's not then you need to explicitly get things pulled in but
there will also be bisection issues.
