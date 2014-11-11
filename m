From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Wed, 12 Nov 2014 00:20:28 +0100
Subject: [GIT PULL] ARM: BCM5301X: DT changes for v3.19
Message-ID: <546299BC.4060704@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Olof, Hi Arnd,

Please consider these BCM5301X ARM based SoC dt updates for v3.19.

The following changes since commit
206c5f60a3d902bc4b56dab2de3e88de5eb06108:

  Linux 3.18-rc4 (2014-11-09 14:55:29 -0800)

are available in the git repository at:

  https://github.com/hauke/linux.git tags/bcm5301x-dt-2014-11-11

for you to fetch changes up to e40e5b5ff7c40abc5b247a45b06f93d5a677ebe1:

  ARM: BCM5301X: activate early printk for Netgear R6250 (2014-11-11
23:55:57 +0100)

- ----------------------------------------------------------------
ARM: BCM5301X: Add some more devices to device tree

The most important part is adding the axi bus to the SoC dtsi file,
this is the main bus on the SoC.

These patches were all send to the arm list and I haven't got any
negative responses.

- ----------------------------------------------------------------
Hauke Mehrtens (1):
      ARM: BCM5301X: activate early printk for Netgear R6250

Rafa? Mi?ecki (2):
      ARM: BCM5301X: Add Broadcom's bus-axi to the DTS file
      ARM: BCM5301X: Add LEDs for Netgear R6250 V1

 arch/arm/boot/dts/bcm4708-netgear-r6250.dts | 36
++++++++++++++++++++++++++++-
 arch/arm/boot/dts/bcm5301x.dtsi             | 16 +++++++++++++
 2 files changed, 51 insertions(+), 1 deletion(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUYpm3AAoJEIZ0px9YPRMyf3EQAI1Yd3hSL1uhCpeVg6q5p7CE
HPAwAOeCln+7luZfaA6A3f0A+maVK8bICChMdvD/fGpaF4a2idJnEyZvgrgWch4K
FGwkaS/0C2UEqChErLwDTG1S+hwWK2zcSvFegT3L27nWZtqwwuJxSUXVnrEclSgv
hVRYdW52oKj/Jz7zAoAfpj4SopoDehw4N+TSBdrT79SmlBTM37KyfKmXB7LWux19
rNH7ZIBCpYyr8gbK3CCH7O0w6DfcfXjdAFAfp5SQhci7gACOo88TOnLN+pfFs0as
HEIQ4NRMLQfup66m7dvShBUg8vOITde6ux6H2ZUd4rT9nYOIe0D8uEW0uguz+OLg
QkmKbWOHsFqq6UMuz5iP0cZr7fFIES9NEborLEmAli+6DI963VUjD9GEgRD7DF52
TpsI0Nwh5ff9a3T3ndvVsMXE4WlCfxovhdNACBvI5NdQhr35o6kko7tdbGpPzK+X
tPmRRyC37B7thKsufWtV2PNlFKSW1jJLvNrHrZXRxsdAhJ+fr00FcVA3QEWQ8nij
6bO+CuyqqR0rudiH8VBS18OieMkh1ghWJwU70F4GZPA7n0vkw6AMk1B3w01+4hDf
mxBmXCJUKFqHbOh6rctcoo+oOtZ85y+Jt+ZfWUr1+U0JwJSusQYsKVu4QdDUQhHA
pne9IctuJSckU+imPqF+
=H/01
-----END PGP SIGNATURE-----
