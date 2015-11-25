From: cory.tusar@pid1solutions.com (Cory Tusar)
Date: Wed, 25 Nov 2015 00:42:49 -0500
Subject: [PATCH 4/4] ARM: dts: vf610-twr: relicense vf610-twr.dts under
 GPLv2/X11
In-Reply-To: <1448323302-23563-1-git-send-email-stefan@agner.ch>
References: <1448323302-23563-1-git-send-email-stefan@agner.ch>
Message-ID: <56554A59.1010306@pid1solutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/23/2015 07:01 PM, Stefan Agner wrote:
> GPLv2-only devicetrees make reuse difficult for software components
> licensed under a different license.
> 
> The consensus is that a GPL/X11 dual-license should allow all necessary
> uses, so relicense the vf610-twr.dts file to this combination.
> 
> CCs were acquired using (updated some email addresses):
> git shortlog -sne --no-merges arch/arm/boot/dts/vf610-twr.dts
> 
> CC: Bill Pringlemeir <bpringle@sympatico.ca>
> CC: Chao Fu <B44548@freescale.com>
> CC: Cory Tusar <cory.tusar@pid1solutions.com>

Acked-by: Cory Tusar <cory.tusar@pid1solutions.com>

> CC: Cosmin Stoica <cosminstefan.stoica@freescale.com>
> CC: Fugang Duan <B38611@freescale.com>
> CC: Jingchang Lu <b35083@freescale.com>
> CC: Shawn Guo <shawnguo@kernel.org>
> CC: Xiubo Li <Li.Xiubo@freescale.com>
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

iEYEARECAAYFAlZVSlkACgkQHT1tsfGwHJ8KNwCfZ447EX1WDTNHtozjnAMJH9SP
y8wAoJDqarHEEUSSYvRQzEln0R6aaNMK
=tTfg
-----END PGP SIGNATURE-----
