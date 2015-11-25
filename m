From: cory.tusar@pid1solutions.com (Cory Tusar)
Date: Wed, 25 Nov 2015 00:38:58 -0500
Subject: [PATCH 2/4] ARM: dts: vf610-colibri: relicense vf*colibri* under
 GPLv2/X11
In-Reply-To: <1448323278-23447-1-git-send-email-stefan@agner.ch>
References: <1448323278-23447-1-git-send-email-stefan@agner.ch>
Message-ID: <56554972.6060200@pid1solutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/23/2015 07:01 PM, Stefan Agner wrote:
> GPLv2-only devicetrees make reuse difficult for software components
> licensed under a different license.
> 
> The consensus is that a GPL/X11 dual-license should allow all necessary
> uses, so relicense the vf*colibri* files to this combination.
> 
> CCs were acquired using:
> git shortlog -sne --no-merges arch/arm/boot/dts/vf*colibri*
> 
> CC: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
> CC: Cory Tusar <cory.tusar@pid1solutions.com>

Acked-by: Cory Tusar <cory.tusar@pid1solutions.com>

> CC: Sanchayan Maity <maitysanchayan@gmail.com>
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

iEYEARECAAYFAlZVSXIACgkQHT1tsfGwHJ/85gCgmqUH+q6crKOHEineLrFWPrA8
5kAAniD8W67H4c/oeDIdy2hPWXjtEO9z
=EewI
-----END PGP SIGNATURE-----
