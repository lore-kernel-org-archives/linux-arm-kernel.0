From: olof@lixom.net (Olof Johansson)
Date: Mon, 21 Nov 2016 15:38:17 -0800
Subject: linux-next: manual merge of the rockchip tree with the arm-soc
 tree
In-Reply-To: <20161122101908.2e967e42@canb.auug.org.au>
References: <20161122101908.2e967e42@canb.auug.org.au>
Message-ID: <CAOesGMhm2n3-7zLD4xUdJGJ7B6p9J_kNdNU-b-z7w+NXGZu_0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 21, 2016 at 3:19 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Heiko,
>
> Today's linux-next merge of the rockchip tree got a conflict in:
>
>   arch/arm64/configs/defconfig
>
> between commit:
>
>   a59294b2f7c7 ("ARM64: defconfig: Enable MMC related configs")
>
> from the arm-soc tree and commit:
>
>   5295a3157348 ("arm64: defconfig: enable RK808 components")
>
> from the rockchip tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

This sounds fine, and it's a conflict we'll resolve when we merge this
material from Heiko.


-Olof
