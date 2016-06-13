From: olof@lixom.net (Olof Johansson)
Date: Mon, 13 Jun 2016 15:45:28 -0700
Subject: [GIT PULL] Ux500 DT updates for v4.8
In-Reply-To: <CACRpkdZ_HPAXVc9Gd3oy5CVb=w76krcb3_Ney-rBb7Hn-YvAKQ@mail.gmail.com>
References: <CACRpkdZ_HPAXVc9Gd3oy5CVb=w76krcb3_Ney-rBb7Hn-YvAKQ@mail.gmail.com>
Message-ID: <20160613224528.GF29879@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2016 at 09:49:59AM +0200, Linus Walleij wrote:
> Hi ARM SoC folks,
> 
> here is a bunch of DT updates to the Ux500 platforms that I'd like to get into
> the ARM SoC tree.
> 
> Please pull it in!
> 
> Yours,
> Linus Walleij
> 
> 
> The following changes since commit af8c34ce6ae32addda3788d54a7e340cad22516b:
> 
>   Linux 4.7-rc2 (2016-06-05 14:31:26 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
> tags/ux500-dt-asoc-1
> 
> for you to fetch changes up to ac07a4e02899b332350b95ee190014c88271eaaa:
> 
>   ARM: dts: UX500: name the GPIO lines on HREFv60plus (2016-06-08
> 09:42:41 +0200)
> 
> ----------------------------------------------------------------
> Ux500 devicetree patches:
> - Move the ab8500 compatible string from the board to the
>   chipset.
> - Define GPIO line names for the boards.
> 
> ----------------------------------------------------------------
> Linus Walleij (3):
>       ARM: dts: Ux500: move compatible string to chipset
>       ARM: dts: Ux500: name the GPIO lines on Snowball
>       ARM: dts: UX500: name the GPIO lines on HREFv60plus
> 
>  arch/arm/boot/dts/ste-dbx5x0.dtsi      |   1 +
>  arch/arm/boot/dts/ste-href.dtsi        |   1 -
>  arch/arm/boot/dts/ste-hrefv60plus.dtsi | 120 +++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/ste-snowball.dts     |  84 ++++++++++++++++++++++-
>  4 files changed, 204 insertions(+), 2 deletions(-)

Merged, thanks.


-Olof
