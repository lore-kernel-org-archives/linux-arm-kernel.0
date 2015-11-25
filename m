From: cory.tusar@pid1solutions.com (Cory Tusar)
Date: Wed, 25 Nov 2015 00:36:03 -0500
Subject: [PATCH 1/4] ARM: dts: vf610: relicense vf???.dtsi under GPLv2/X11
In-Reply-To: <1448323069-23208-2-git-send-email-stefan@agner.ch>
References: <1448323069-23208-1-git-send-email-stefan@agner.ch>
 <1448323069-23208-2-git-send-email-stefan@agner.ch>
Message-ID: <565548C3.2070903@pid1solutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/23/2015 06:57 PM, Stefan Agner wrote:
> GPLv2-only devicetrees make reuse difficult for software components
> licensed under a different license.
> 
> The consensus is that a GPL/X11 dual-license should allow all necessary
> uses, so relicense the vfxxx.dtsi, vf500.dtsi and vf610.dtsi files to
> this combination.
> 
> CCs were acquired using (updated some email addresses):
> git shortlog -sne --no-merges arch/arm/boot/dts/vf???.dtsi
> 
> CC: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
> CC: Chao Fu <B44548@freescale.com>
> CC: Cory Tusar <cory.tusar@pid1solutions.com>

Acked-by: Cory Tusar <cory.tusar@pid1solutions.com>

> CC: Cosmin Stoica <cosminstefan.stoica@freescale.com>
> CC: Frank Li <Frank.Li@freescale.com>
> CC: Fugang Duan <B38611@freescale.com>
> CC: Huang Shijie <b32955@freescale.com>
> CC: Jingchang Lu <jingchang.lu@freescale.com>
> CC: Lucas Stach <l.stach@pengutronix.de>
> CC: Sanchayan Maity <maitysanchayan@gmail.com>
> CC: Shawn Guo <shawnguo@kernel.org>
> CC: Stephen Warren <swarren@wwwdotorg.org>
> CC: Xiubo Li <Li.Xiubo@freescale.com>
> CC: Yuan Yao <yao.yuan@freescale.com>
> Signed-off-by: Stefan Agner <stefan@agner.ch>


- -- 
Cory Tusar
Principal
PID 1 Solutions, Inc.


"There are two ways of constructing a software design.  One way is to
 make it so simple that there are obviously no deficiencies, and the
 other way is to make it so complicated that there are no obvious
 deficiencies."  --Sir Charles Anthony Richard Hoare

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlZVSMMACgkQHT1tsfGwHJ/rYQCgnPy1XpNbNsUDGrutOANmQwoi
Q0YAmwfO5LbZvZOLIqZyLLdc34sLBEHn
=hsX0
-----END PGP SIGNATURE-----
