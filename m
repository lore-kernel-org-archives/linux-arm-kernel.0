From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 18 Jan 2017 11:06:53 -0800
Subject: linux-next: manual merge of the amlogic tree with the arm-soc tree
In-Reply-To: <20170118095531.37f33df0@canb.auug.org.au> (Stephen Rothwell's
 message of "Wed, 18 Jan 2017 09:55:31 +1100")
References: <20170118095531.37f33df0@canb.auug.org.au>
Message-ID: <m2inpc192q.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> Today's linux-next merge of the amlogic tree got a conflict in:
>
>   arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
>
> between commit:
>
>   f7bcd4b6f698 ("ARM64: dts: meson-gxbb-odroidc2: Disable SCPI DVFS")
>
> from the arm-soc tree and commit:
>
>   47961f1353b8 ("ARM64: dts: meson-gx: move the SCPI and SRAM nodes to meson-gx")
>
> from the amlogic tree.

The latter has been dropped from the amlogic pending some ongoing
discussion, but I forgot to push an updated for-next. That's remedied
now.

Kevin
