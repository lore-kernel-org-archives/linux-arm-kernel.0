From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 16 Jul 2018 07:57:18 +1000
Subject: linux-next: Signed-off-by missing for commits in the arm-soc tree
Message-ID: <20180716075718.4e5ef491@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Commits

  b8ccf02a5014 ("ARM: dts: bcm283x: Add the PMU to the devicetree.")
  b7dd29b401f5 ("ARM: dts: bcm283x: Add Transposer block")
  74d1e007915f ("hwmon: Add support for RPi voltage sensor")
  70eea1bbb556 ("firmware: raspberrypi: Register hwmon driver")
  a1547e0bca51 ("firmware: raspberrypi: Remove VLA usage")

are missing a Signed-off-by from their committer.

-- 
Cheers,
Stephen Rothwell
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180716/752046b0/attachment.sig>
