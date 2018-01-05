From: olof@lixom.net (Olof Johansson)
Date: Thu, 4 Jan 2018 23:29:18 -0800
Subject: [GIT PULL] ARM: dts: uniphier: UniPhier DT updates for v4.16
In-Reply-To: <CAK7LNAQts_obeboujnhsM_kBixwUH4K8yFt0dmQ2HkV03RmwNw@mail.gmail.com>
References: <CAK7LNAQts_obeboujnhsM_kBixwUH4K8yFt0dmQ2HkV03RmwNw@mail.gmail.com>
Message-ID: <20180105072918.vj4q5gdv2g6wedaj@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Fri, Dec 29, 2017 at 10:32:24PM +0900, Masahiro Yamada wrote:
> Hi Arnd, Olof,
> 
> Here are UniPhier DT (32bit) updates for the v4.16 merge window.
> Please pull!
> 
> 
> The following changes since commit 50c4c4e268a2d7a3e58ebb698ac74da0de40ae36:
> 
>   Linux 4.15-rc3 (2017-12-10 17:56:26 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
> tags/uniphier-dt-v4.16

Tiny tiny nit: It makes our life a little easier if you don't linewrap the
URL+tag, since it's easier to copy-paste without a linebreak.

> for you to fetch changes up to 6fa9b0255099fcd289f7e3857714532843044c76:
> 
>   ARM: dts: uniphier: add has-transaction-translator property to usb
> node for LD4, sLD8 and Pro4 (2017-12-27 23:59:37 +0900)
> 
> ----------------------------------------------------------------
> UniPhier ARM SoC DT updates for v4.16
> 
> - clean up gpios properties by macro
> - add efuse nodes
> - add has-transaction-translator property to generic-ehci nodes
> 
> ----------------------------------------------------------------
> Keiji Hayashibara (1):
>       ARM: dts: uniphier: add efuse node for UniPhier 32bit SoC
> 
> Kunihiko Hayashi (1):
>       ARM: dts: uniphier: add has-transaction-translator property to
> usb node for LD4, sLD8 and Pro4

Another small nit: This patch subject is a bit on the long side. Try to
keep it to ~60 characters if you can.

Merged the branch.


Thanks!

-Olof
> 
> Masahiro Yamada (1):
>       ARM: dts: uniphier: use macros in dt-bindings header
> 
>  arch/arm/boot/dts/uniphier-ld4-ref.dts  |  2 +-
>  arch/arm/boot/dts/uniphier-ld4.dtsi     | 23 +++++++++++++++++
>  arch/arm/boot/dts/uniphier-ld6b-ref.dts |  2 +-
>  arch/arm/boot/dts/uniphier-pro4-ref.dts |  2 +-
>  arch/arm/boot/dts/uniphier-pro4.dtsi    | 27 +++++++++++++++++++
>  arch/arm/boot/dts/uniphier-pro5.dtsi    | 33 ++++++++++++++++++++++++
>  arch/arm/boot/dts/uniphier-pxs2.dtsi    | 19 ++++++++++++++
>  arch/arm/boot/dts/uniphier-sld8-ref.dts |  2 +-
>  arch/arm/boot/dts/uniphier-sld8.dtsi    | 23 +++++++++++++++++
>  9 files changed, 129 insertions(+), 4 deletions(-)
> 
> 
> -- 
> Best Regards
> Masahiro Yamada
