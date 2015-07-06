From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 6 Jul 2015 10:35:12 +0800
Subject: [GIT PULL] CSR atlas7 pinctrl descriptions for 4.2
In-Reply-To: <CAGsJ_4x7rSFCJW6=9=WpGSUBf0yaCpcxXA22W5k+mZ=9qk5SGg@mail.gmail.com>
References: <CAGsJ_4x7rSFCJW6=9=WpGSUBf0yaCpcxXA22W5k+mZ=9qk5SGg@mail.gmail.com>
Message-ID: <CAGsJ_4yXsmB9tSpwaLYPLAJHXVRqgZeaAO_VirOX2F3XE_o8bA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-06-10 15:35 GMT+08:00 Barry Song <21cnbao@gmail.com>:
> Hi Arnd, Kevin, Olof,
>
> The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:
>
>   Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/baohua/linux.git
> tags/atlas7-pinctrl-dts-for-4.2
>
> for you to fetch changes up to 27b0d37e4209f3fc40c65e2b7936ee4154f4070d:
>
>   ARM: dts: atlas7: add pinctrl and gpio descriptions (2015-06-10
> 15:00:50 +0800)

Hi Arnd, Kevin, Olof,

have you missed this one? it is a follow-up patch to "pinctrl: sirf:
add sirf atlas7 pinctrl and gpio support"

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=f9367793293d2262460942b0a4904c21857a1a8b

do we still have any chance to make it in 4.2?


>
> ----------------------------------------------------------------
> add atlas7 pinctrl dts stuff
>
> add atlas7 pin groups and gpio/pin mapping descriptions
>
> ----------------------------------------------------------------
> Wei Chen (1):
>       ARM: dts: atlas7: add pinctrl and gpio descriptions
>
>  arch/arm/boot/dts/atlas7.dtsi | 1042 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 1041 insertions(+), 1 deletion(-)
>
> -barry

-barry
