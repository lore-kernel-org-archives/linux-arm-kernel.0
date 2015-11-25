From: cory.tusar@pid1solutions.com (Cory Tusar)
Date: Wed, 25 Nov 2015 00:41:22 -0500
Subject: [PATCH 3/4] ARM: dts: vf610-cosmic: relicense vf610-cosmic.dts
 under GPLv2/X11
In-Reply-To: <1448323291-23505-1-git-send-email-stefan@agner.ch>
References: <1448323291-23505-1-git-send-email-stefan@agner.ch>
Message-ID: <56554A02.8080202@pid1solutions.com>
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
> git shortlog -sne --no-merges arch/arm/boot/dts/vf610-cosmic.dts
> 
> CC: Cory Tusar <cory.tusar@pid1solutions.com>

Acked-by: Cory Tusar <cory.tusar@pid1solutions.com>

> CC: Matt Porter <matt.porter@linaro.org>
> CC: Olof Johansson <olof@lixom.net>
> CC: Shawn Guo <shawnguo@kernel.org>
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

iEYEARECAAYFAlZVSgIACgkQHT1tsfGwHJ8+WgCgpIksiDYnrAinLzsEv11cl5Ez
Hb4An1Bm9qpykikhgs+BDjuNiDp7KDC/
=8817
-----END PGP SIGNATURE-----
