From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 20 Sep 2016 14:02:25 -0700
Subject: linux-next: manual merge of the amlogic tree with the arm-soc tree
In-Reply-To: <20160920101938.5d46a0ab@canb.auug.org.au> (Stephen Rothwell's
 message of "Tue, 20 Sep 2016 10:19:38 +1000")
References: <20160920101938.5d46a0ab@canb.auug.org.au>
Message-ID: <7hk2e6i8ta.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> Today's linux-next merge of the amlogic tree got a conflict in:
>
>   arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
>
> between commit:
>
>   8735053d7968 ("ARM64: dts: meson-gxbb-p20x: Enable USB Nodes")
>
> from the arm-soc tree and commit:
>
>   d82801a385a1 ("ARM64: dts: meson-gxbb-p20x: Enable USB Nodes")
>
> from the amlogic tree.
>
> This patch was modified before being merged into the arm-soc tree.
> Please clean up the amlogic tree.

Cleaned up.

I forgot to push the updated amlogic/for-next after sending pull
requests to arm-soc.

Kevin
