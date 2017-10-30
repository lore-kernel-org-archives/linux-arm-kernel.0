From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 Oct 2017 14:51:13 +0100
Subject: linux-next: manual merge of the sunxi tree with the arm-soc tree
In-Reply-To: <20171030122200.z5sj2riar4vfoiwo@sirena.co.uk>
References: <20171030122200.z5sj2riar4vfoiwo@sirena.co.uk>
Message-ID: <CAK8P3a12bGTr1-royZZeuu69kD+59MhVZeJJ-8iVviGg33hA-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 30, 2017 at 1:22 PM, Mark Brown <broonie@kernel.org> wrote:
> Hi all,
>
> Today's linux-next merge of the sunxi tree got a conflict in:
>
>    arch/arm/boot/dts/sunxi-h3-h5.dtsi
>    arch/arm/boot/dts/sun7i-a20.dtsi
>    arch/arm/boot/dts/sun6i-a31.dtsi
>    arch/arm/boot/dts/sun4i-a10.dtsi
>
> between commit:
>
>    8dccafaa281aa1 ("arm: dts: fix unit-address leading 0s")
>
> from the arm-soc tree and various commits from the sunxi tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks!

I think I did the same merge when I pulled in the sunxi/dt branch
today, so it should be resolved next time.

      Arnd
