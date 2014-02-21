From: olof@lixom.net (Olof Johansson)
Date: Fri, 21 Feb 2014 14:29:47 -0800
Subject: [GIT PULL] bcm pinctrl rename
In-Reply-To: <CAEPRUYpCVpV7HwuO6c95ybk3yp1teJgW-9qwyHnjKbs03C9bgQ@mail.gmail.com>
References: <CAEPRUYpCVpV7HwuO6c95ybk3yp1teJgW-9qwyHnjKbs03C9bgQ@mail.gmail.com>
Message-ID: <20140221222947.GB13233@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 09:20:13AM -0800, Christian Daudt wrote:
> The following changes since commit b28a960c42fcd9cfc987441fa6d1c1a471f0f9ed:
> 
>   Linux 3.14-rc2 (2014-02-09 18:15:47 -0800)
> 
> are available in the git repository at:
> 
>   git://github.com/broadcom/bcm11351.git tags/bcm-for-3.14-pinctrl-rename
> 
> for you to fetch changes up to f5310a1712b68c7f83539fce6ebbfb6f0f510f5b:
> 
>   Update dtsi with new pinctrl compatible string (2014-02-12 09:06:53 -0800)
> 
> ----------------------------------------------------------------
> Renaming pinctrl code to keep in line with rest of bcm mobile
> 
> Given that this driver has been in the works for a while, it
> was written prior to the code standardizing on bcm-based naming.
> this patchset brings it in line with the remainder of the code.
> 
> ----------------------------------------------------------------
> Sherman Yin (4):
>       pinctrl: Rename Broadcom Capri pinctrl binding
>       pinctrl: Rename Broadcom Capri pinctrl driver
>       Update bcm_defconfig with new pinctrl CONFIG
>       Update dtsi with new pinctrl compatible string

Hi,

(As per irc discussion). The rename isn't the right thing to do at this
time in the release, but the binding needs to be tweaked before it ships
in a full release, or we'll always need to live with it.

So, I'll be happy to take the bindings piece and the dtsi piece (and the
small edit to the driver to change the compatible string match table),
but the file rename and Kconfig entry edit is 3.15 material.

Please send new pull request with just that (or, if you prefer, just send the
patches and we can apply them too).


-Olof
